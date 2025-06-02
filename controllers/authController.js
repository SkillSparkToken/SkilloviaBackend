const User = require("../models/User");
const verifyEmail = require("../models/Verify");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const twilioConfig = require("../config/twilio");
const Notifications = require("../mail/notifications");
const { getClientIp } = require("../middlewares/ipgetter");
const { getCoordinatesFromIp } = require("../utils/geolocation");
const createWalletForUser = require("../utils/createWalletUtils");
// const { createWalletForUser } = require("./walletController");

const registerUser = async (req, res) => {
  try {
    const check = await User.checkUserExist(req.body.phone, req.body.email);

    if (!check) {
      const user = await User.createUser(req.body);

      const wallet = await createWalletForUser(user._id); // Pass MongoDB _id

      return res.status(201).json({
        status: "success",
        message: "User registered successfully.",
        data: user,
        wallet,
      });
    } else {
      return res.status(400).json({
        status: "error",
        message: "User with same email or phone number already exists.",
        data: null,
      });
    }
  } catch (error) {
    console.error("Registration error:", error);
    return res.status(500).json({
      status: "error",
      message: "Registration failed.",
      data: error.message || error,
    });
  }
};
// handles user login
const login = async (req, res) => {
  const { email, phone, password } = req.body;

  try {
    let user = email
      ? await User.findByEmail(email)
      : await User.findByPhone(phone);

    if (!user) {
      return res.status(400).send({
        status: "error",
        message: "Email/Phone or password is not correct",
        data: null,
      });
    }

    const validPass = await bcrypt.compare(password, user.password);
    if (!validPass) {
      return res.status(400).send({
        status: "error",
        message: "Invalid password",
        data: null,
      });
    }

    // Generate tokens
    const accessToken = generateAccessToken({
      id: user._id,
      email: user.email,
      phone: user.phone,
      role_id: user.role_id,
    });

    const refreshToken = jwt.sign(
      {
        id: user._id,
        email: user.email,
        phone: user.phone,
        role_id: user.role_id,
      },
      process.env.REFRESH_TOKEN_SECRET
    );

    // Save refresh token to user doc
    await User.storeRefreshToken(user._id, refreshToken);

    // Set refresh token cookie
    res.cookie("jwt", refreshToken, {
      httpOnly: true,
      secure: true,
      sameSite: "None",
      maxAge: 24 * 60 * 60 * 1000,
    });

    // Update coordinates if needed
    const currentDate = new Date().toISOString();

    if (
      !user.location_updated_at ||
      (new Date(currentDate) - new Date(user.location_updated_at)) /
        (1000 * 60 * 60 * 24) >
        3
    ) {
      const clientIp = req.clientIp;
      const { lat, lng, accuracy } = await getCoordinatesFromIp(clientIp);
      await User.updateCoordinates(lat, lng, accuracy, currentDate, user._id);
    }

    return res.status(200).send({
      status: "success",
      message: "Login was successful",
      data: { accessToken, refreshToken },
    });
  } catch (error) {
    console.error("Login Error:", error);
    return res.status(500).json({
      status: "error",
      message: "Failed to login user.",
      data: error.message,
    });
  }
};

const refreshToken = async (req, res) => {
  const refreshToken = req.body.token;
  if (refreshToken == null) return res.sendStatus(401);

  const token = await User.getRefreshToken(refreshToken);
  if (token && token.length < 0) return res.sendStatus(403);

  jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (error, user) => {
    if (error) return res.sendStatus(403);
    const accessToken = generateLongLiveAccessToken({
      id: user.id,
      email: user.email,
      phone: user.phone,
      lat: user.lat,
      lon: user.lon,
      role_id: user.role_id,
    });

    res.status(200).send({
      status: "success",
      message: "Refresh token retrieved successfully",
      data: { accessToken: accessToken },
    });
  });
};

const refreshTokenWeb = async (req, res) => {
  const cookies = req.cookies;
  if (!cookies.jwt) return res.sendStatus(401);
  const refreshToken = cookies.jwt;
  res.clearCookie("jwt", { httpOnly: true, sameSite: "None", secure: true });

  const token = await User.getRefreshToken(refreshToken);
  if (token && token.length < 0) return res.sendStatus(403);

  jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (error, user) => {
    if (error) return res.json(error);
    const accessToken = generateLongLiveAccessToken({
      id: user.id,
      email: user.email,
      phone: user.phone,
      lat: user.lat,
      lon: user.lon,
      role_id: user.role_id,
    });

    // Store refresh token
    const storereFreshToken = User.storeRefreshToken(accessToken);

    // Creates Secure Cookie with refresh token
    res.cookie("jwt", accessToken, {
      httpOnly: true,
      secure: true,
      sameSite: "None",
      maxAge: 24 * 60 * 60 * 1000,
    });

    res.status(200).send({
      status: "success",
      message: "Refresh token retrieved successfully",
      data: { id: user.id, accessToken: accessToken },
    });
  });
};

const changePassword = async (req, res) => {
  const userId = parseInt(req.params.id);
  const { password, newPassword } = req.body;

  if (password != null && newPassword != null) {
    try {
      const user = await User.findById(userId);

      const validPass = await bcrypt.compare(password, user.password);
      if (!validPass) {
        return res.status(400).send({
          status: "error",
          message: "Invalid password",
          data: null,
        });
      }

      const hashedPassword = newPassword
        ? await bcrypt.hash(newPassword, 10)
        : null;
      const data = await User.resetPassword(userId, hashedPassword);

      res.status(201).json({
        status: "success",
        message: "Password reset was successful",
        data: data,
      });
    } catch (error) {
      res
        .status(500)
        .json({ status: "error", message: "Registration failed." });
    }
  } else {
    return res.status(400).send({
      status: "error",
      message: "missing parameters",
      data: null,
    });
  }
};

const sendVerificationCode = async (req, res) => {
  const { phone } = req.body;

  try {
    // Send a verification code
    const verification = await twilioConfig.sendVerificationCode(phone);
    res.status(200).json({
      status: "success",
      message: "Verification code sent.",
      data: verification,
    });
  } catch (error) {
    console.error("Twilio Test Error:", error.message);
    res.status(400).json({
      status: "Twilio error",
      message: "An error occured. Try again",
      data: error.message,
    });
  }
};

const verifyPhone = async (req, res) => {
  const { phone, code } = req.body;

  try {
    const isVerified = await twilioConfig.verifyCode(phone, code);

    res.status(200).json({
      status: "success",
      message: "Verification was successful.",
      data: isVerified,
    });
  } catch (error) {
    console.error("Twilio Test Error:", error.message);
    res.status(400).json({
      status: "Twilio error",
      message: "An error occured. Try again",
      data: error.message,
    });
  }
};

const AllVerifyEmail = async (req, res) => {
  const { email, code } = req.body;

  try {
    const data = await verifyEmail.verifyUserEmail(email, code);
    if (data != null) {
      res.status(200).json({
        status: "success",
        message: "Verification was successfully.",
        data: data,
      });
      //await User.updateVerificationStatus(email, 1);
    } else {
      res
        .status(400)
        .json({ status: "error", message: "Verification failed", data: null });
    }
  } catch (error) {
    console.error("error:", error.message);
    res.status(500).json({
      status: "error",
      message: "An error occured. Try again",
      data: error.message,
    });
  }
};

const resendEmailVerirficationCode = async (req, res) => {
  const { email } = req.body;
  const code = Math.floor(1000 + Math.random() * 9000);

  try {
    if (email != null) {
      let user;
      const check = await verifyEmail.checkVerificationExist(email);
      if (check != null) {
        user = await verifyEmail.updateVerificationCode(email, code);
      } else {
        user = await verifyEmail.insertVerificationCode(email, code);
      }

      const data = { recepient_name: "there", code: code };
      await Notifications.whenUserRegister(email, data);

      res.status(200).json({
        status: "success",
        message: "Verification resent successfully.",
        data: user,
      });
    }
  } catch (error) {
    console.error("error:", error.message);
    res.status(500).json({
      status: "error",
      message: "An error occured. Try again",
      data: error.message,
    });
  }
};

function generateAccessToken(user) {
  return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "12h" });
}

function generateLongLiveAccessToken(user) {
  return jwt.sign(user, process.env.REFRESH_TOKEN_SECRET, { expiresIn: "2d" });
}

const adminDelete = async (req, res) => {
  const email = req.params.email;

  try {
    const checkUser = await User.findByEmail(email);
    if (checkUser == null) {
      return res.status(400).send({
        status: "error",
        message: "No user found",
        data: null,
      });
    }

    const user = await User.deleteUser(email);
    res.status(200).json({
      status: "success",
      message: "User deleted successfully.",
      data: user,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to delete user.",
      data: error,
    });
  }
};

const forgotPassword = async (req, res) => {
  const { email } = req.body;

  try {
    // Check if user exists
    const user = await User.findByEmail(email);
    console.log("User found by email:", user);
    if (user == null) {
      return res
        .status(404)
        .json({ status: "error", message: "User not found", data: null });
    }

    const userId = user.id;
    const token = jwt.sign({ userId }, process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: "1h",
    });

    // Store token in DB
    await User.storeResetPasswordToken(userId, token);

    // Send Reset Email
    const resetLink = `${process.env.FRONTEND_URL}/reset-psw?token=${token}`;
    const data = {
      recepient_name: user.firstname,
      link: resetLink,
      code: token,
    };
    await Notifications.whenPasswordReset(email, data);

    res.status(200).json({
      status: "success",
      message: "Password reset link sent to your email",
      data: email,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

const resetPassword = async (req, res) => {
  const { token, newPassword } = req.body;

  try {
    // Verify token
    const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
    const userId = decoded.userId;

    // Check if token is valid
    const tokenQuery = await User.getPasswordResetTokens(token, userId);
    if (tokenQuery == null) {
      return res.status(400).json({
        status: "error",
        message: "Invalid or expired token",
        data: null,
      });
    }

    // Hash new password
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Update password in DB
    await User.resetPassword(userId, hashedPassword);

    // Delete the used token
    await User.deletePasswordResetTokens(token);

    res.status(200).json({
      status: "success",
      message: "Password updated successfully",
      data: [],
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({
      status: "error",
      message: "Invalid or expired token",
      data: null,
    });
  }
};

module.exports = {
  registerUser,
  login,
  refreshToken,
  refreshTokenWeb,
  resetPassword,
  verifyPhone,
  sendVerificationCode,
  AllVerifyEmail,
  resendEmailVerirficationCode,
  adminDelete,
  forgotPassword,
  changePassword,
};
