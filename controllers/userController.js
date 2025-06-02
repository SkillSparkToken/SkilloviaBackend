const Skill = require("../models/Skill");
const User = require("../models/User");
const StripeAccount = require("../models/Stripe");
const bcrypt = require("bcrypt");
const {
  createConnectedAccount,
  generateAccountLink,
  processSplitPayment,
} = require("../utils/stripe");
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
const Wallet = require("../models/Wallet"); // your Wallet mongoose model

exports.updateUser = async (req, res) => {
  const userId = req.params.id;
  const updates = req.body;

  try {
    const updatedUser = await User.update(userId, updates);
    res.status(200).json({
      status: "success",
      message: "User updated successfully.",
      data: updatedUser,
    });
  } catch (error) {
    res
      .status(500)
      .json({ status: "error", message: "Failed to update user." });
  }
};

exports.changeNotificationType = async (req, res) => {
  const userId = req.user.id;
  const { notification_type } = req.body;

  try {
    const updatedNotification = await User.changeNotificationType(
      userId,
      notification_type
    );
    res.status(200).json({
      status: "success",
      message: "Notification type updated successfully.",
      data: updatedNotification,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to update notification type.",
    });
  }
};

exports.changeAppearanceMode = async (req, res) => {
  const userId = req.user.id;
  const { appearance_mode } = req.body;

  try {
    const mode = await User.changeAppearanceMode(userId, appearance_mode);
    res.status(200).json({
      status: "success",
      message: "Appearance mode updated successfully.",
      data: mode,
    });
  } catch (error) {
    res
      .status(500)
      .json({ status: "error", message: "Failed to update appearance mode." });
  }
};

// exports.getProfileByUserId = async (req, res) => {
//   const userId = parseInt(req.params.id);

//   try {
//     const data = await User.getProfileByUserId(userId);

//     if (data.length === 0) {
//       return res
//         .status(404)
//         .json({
//           status: "error",
//           message: "User profile not found.",
//           data: data,
//         });
//     }

//     const {
//       id,
//       phone,
//       email,
//       firstname,
//       lastname,
//       gender,
//       notification_type,
//       appearance_mode,
//       photourl,
//       bio,
//       spark_token_balance,
//       cash_balance,
//       total_followers,
//       total_following,
//       location,
//       street,
//       zip_code,
//       created_at,
//       updated_at,
//       referral_code,
//       website,
//     } = data[0];

//     // Map skills to an array
//     const skills = data[0].skills.map((item) => ({
//       skill_id: item.skill_id,
//       description: item.description,
//       skill_type: item.skill_type,
//       experience_level: item.experience_level,
//       hourly_rate: item.hourly_rate,
//       thumbnail01: item.thumbnail01,
//       thumbnail02: item.thumbnail02,
//       thumbnail03: item.thumbnail03,
//       thumbnail04: item.thumbnail04,
//     }));

//     const userProfile = {
//       id,
//       phone,
//       email,
//       firstname,
//       lastname,
//       gender,
//       notification_type,
//       appearance_mode,
//       photourl,
//       bio,
//       spark_token_balance,
//       cash_balance,
//       total_followers,
//       total_following,
//       location,
//       street,
//       zip_code,
//       referral_code,
//       website,
//       created_at,
//       updated_at,
//       skills: skills,
//     };

//     res
//       .status(200)
//       .json({
//         status: "success",
//         message: "User profile retrieved successfully.",
//         data: userProfile,
//       });
//   } catch (error) {
//     console.error("Error in getProfileByUserId:", error);
//     res
//       .status(500)
//       .json({
//         status: "error",
//         message: "Failed to retrieve profile.",
//         error: error.message,
//       });
//   }
// };
exports.getProfileByUserId = async (req, res) => {
  const userId = req.params.id; // string id

  try {
    const data = await User.getProfileByUserId(userId);

    if (!data) {
      // no profile found for given userId
      return res.status(404).json({
        status: "error",
        message: "User profile not found.",
        data: null,
      });
    }

    // destructure properties from data object directly (not data[0])
    const {
      _id: id, // MongoDB _id, rename to id
      phone,
      email,
      firstname,
      lastname,
      gender,
      notification_type,
      appearance_mode,
      photourl,
      bio,
      spark_token_balance,
      cash_balance,
      total_followers,
      total_following,
      location,
      street,
      zip_code,
      created_at,
      updated_at,
      referral_code,
      website,
      iskyc,
      isPaymentMethod,
      isStripeLinked,
      skills,
    } = data;

    // Map skills array if exists
    const mappedSkills = (skills || []).map((item) => ({
      skill_id: item.skill_id,
      description: item.description,
      skill_type: item.skill_type,
      experience_level: item.experience_level,
      hourly_rate: item.hourly_rate,
      thumbnail01: item.thumbnail01,
      thumbnail02: item.thumbnail02,
      thumbnail03: item.thumbnail03,
      thumbnail04: item.thumbnail04,
    }));

    const isProfileImage = photourl ? true : false
    const isSkills = mappedSkills.length > 0 ? true : false
    const isProfileBio = street ? true : false

    const userProfile = {
      id: id.toString(),
      phone,
      email,
      firstname,
      lastname,
      gender,
      notification_type,
      appearance_mode,
      photourl,
      bio,
      spark_token_balance,
      cash_balance,
      total_followers,
      total_following,
      location,
      street,
      zip_code,
      referral_code,
      website,
      isProfileImage,
      isSkills,
      isProfileBio,
      iskyc,
      isPaymentMethod,
      isStripeLinked,
      created_at,
      updated_at,
      skills: mappedSkills,
    };

    return res.status(200).json({
      status: "success",
      message: "User profile retrieved successfully.",
      data: userProfile,
    });
  } catch (error) {
    console.error("Error in getProfileByUserId:", error);
    return res.status(500).json({
      status: "error",
      message: "Failed to retrieve profile.",
      error: error.message,
    });
  }
};

// exports.getBasiceProfileByUserId = async (req, res) => {
//   const userId = req.params.id;

//   try {
//     const data = await User.getProfileByUserId(userId);
//     // Assuming getProfileByUserId returns array of user(s), adjust if you use findOne

//     if (!data || data.length === 0) {
//       return res.status(404).json({
//         status: "error",
//         message: "User profile not found.",
//         data: data,
//       });
//     }

//     const wallet = (await Wallet.findOne({ userId })) || {
//       balance: 0,
//       spark_tokens: 0,
//       currency: "gbp",
//     };

//     const user = data[0];
//     const skills =
//       user.skills?.map((item) => ({
//         skill_id: item.skill_id,
//         description: item.description,
//         skill_type: item.skill_type,
//         spark_token: item.spark_token || 0,
//         experience_level: item.experience_level,
//         hourly_rate: item.hourly_rate,
//         thumbnail01: item.thumbnail01,
//         thumbnail02: item.thumbnail02,
//         thumbnail03: item.thumbnail03,
//         thumbnail04: item.thumbnail04,
//       })) || [];

//     const userProfile = {
//       id: user.id,
//       phone: user.phone,
//       email: user.email,
//       firstname: user.firstname,
//       lastname: user.lastname,
//       gender: user.gender,
//       notification_type: user.notification_type,
//       appearance_mode: user.appearance_mode,
//       photourl: user.photourl,
//       bio: user.bio,
//       total_followers: user.total_followers,
//       total_following: user.total_following,
//       location: user.location,
//       street: user.street,
//       zip_code: user.zip_code,
//       referral_code: user.referral_code,
//       website: user.website,
//       wallet: {
//         balance: wallet.balance,
//         spark_tokens: wallet.spark_tokens,
//         currency: wallet.currency,
//       },
//       skills,
//     };

//     res.status(200).json({
//       status: "success",
//       message: "User profile retrieved successfully.",
//       data: userProfile,
//     });
//   } catch (error) {
//     console.error("Profile error:", error);
//     res.status(500).json({
//       status: "error",
//       message: "Failed to retrieve profile.",
//     });
//   }
// };
exports.getBasiceProfileByUserId = async (req, res) => {
  const userId = req.params.id;

  try {
    const data = await User.getProfileByUserId(userId);
    console.log("Fetched data:", data);

    const user = Array.isArray(data) ? data[0] : data;

    if (!user) {
      return res.status(404).json({
        status: "error",
        message: "User profile not found or invalid format.",
        data,
      });
    }

    const wallet = (await Wallet.findOne({ userId })) || {
      balance: 0,
      spark_tokens: 0,
      currency: "gbp",
    };

    const skills = Array.isArray(user.skills)
      ? user.skills.map((item) => ({
          skill_id: item.skill_id,
          description: item.description,
          skill_type: item.skill_type,
          spark_token: item.spark_token || 0,
          experience_level: item.experience_level,
          hourly_rate: item.hourly_rate,
          thumbnail01: item.thumbnail01,
          thumbnail02: item.thumbnail02,
          thumbnail03: item.thumbnail03,
          thumbnail04: item.thumbnail04,
        }))
      : [];

    const userProfile = {
      id: user.id,
      phone: user.phone,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      gender: user.gender,
      notification_type: user.notification_type,
      appearance_mode: user.appearance_mode,
      photourl: user.photourl,
      bio: user.bio,
      total_followers: user.total_followers,
      total_following: user.total_following,
      location: user.location,
      street: user.street,
      zip_code: user.zip_code,
      referral_code: user.referral_code,
      website: user.website,
      wallet: {
        balance: wallet.balance,
        spark_tokens: wallet.spark_tokens,
        currency: wallet.currency,
      },
      skills,
    };

    res.status(200).json({
      status: "success",
      message: "User profile retrieved successfully.",
      data: userProfile,
    });
  } catch (error) {
    console.error("Profile error:", error);
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve profile.",
    });
  }
};

exports.compareSparkTokens = async (req, res) => {
  const userId = req.user.id;
  const { skillId, targetUserId } = req.body;

  try {
    const targetSkill = await Skill.findOne({
      _id: skillId,
      userId: targetUserId,
    });

    if (!targetSkill) {
      return res
        .status(404)
        .json({ message: "Target skill not found for the other user" });
    }

    const requiredTokens = parseInt(targetSkill.spark_token);
    if (!requiredTokens || isNaN(requiredTokens)) {
      return res
        .status(400)
        .json({ message: "Invalid spark_token in target skill" });
    }

    const userSkills = await Skill.find({ userId });

    if (!userSkills || userSkills.length === 0) {
      return res.status(400).json({ message: "User has no skills" });
    }

    const hasEnoughTokens = userSkills.some((skill) => {
      const userToken = parseInt(skill.spark_token);
      return !isNaN(userToken) && userToken >= requiredTokens;
    });

    if (hasEnoughTokens) {
      return res
        .status(200)
        .json({ message: "Sufficient SparkTokens", canPay: true });
    } else {
      return res
        .status(400)
        .json({ message: "Insufficient SparkTokens", canPay: false });
    }
  } catch (error) {
    console.error("Error comparing SparkTokens:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

exports.getBasiceProfileByUserName = async (req, res) => {
  const name = req.params.name;

  try {
    console.log("Searching for user:", name);
    const data = await User.getProfileByUserName(name);
    console.log("User data:", data);
    if (data.length === 0) {
      return res.status(404).json({
        status: "error",
        message: "User profile not found.",
        data: data,
      });
    }

    res.status(200).json({
      status: "success",
      message: "User profile retrieved successfully.",
      data: data,
    });
  } catch (error) {
    console.error("Database error:", error.message, error.stack);
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve profile.",
      error: error.message,
    });
  }
};

// exports.profilePhotoUpload = async (req, res) => {
//   const userId = req.user.id;

//   if (req.filePaths != null) {
//     const filePath = req.filePaths;
//     //console.log("PTH ", filePath)
//     const file = filePath.slice(15);

//     try {
//       const mode = await User.changeAvatar(userId, file);
//       res.status(200).json({
//         status: "success",
//         message: "Profile photo updated successfully",
//         data: mode,
//       });
//     } catch (error) {
//       res
//         .status(500)
//         .json({ status: "error", message: "Failed to upload photo" });
//     }
//   } else {
//     res.status(400).send({
//       status: "error",
//       message: "No image found",
//       data: null,
//     });
//   }
// };
exports.profilePhotoUpload = async (req, res) => {
  try {
    const userId = req.user.id;

    if (!req.file) {
      return res.status(400).json({
        status: "error",
        message: "No image found",
        data: null,
      });
    }

    const fileUrl = req.file.location; // S3 URL

    // Store file URL in the database (Assuming `changeAvatar` updates the DB)
    const mode = await User.changeAvatar(userId, fileUrl);

    return res.status(200).json({
      status: "success",
      message: "Profile photo updated successfully",
      data: mode,
    });
  } catch (error) {
    console.error("Upload Error:", error);
    return res.status(500).json({
      status: "error",
      message: "Failed to upload photo",
      error: error.message,
    });
  }
};

exports.profilePhotoUploadS3 = async (req, res) => {
  const userId = req.user.id;
  const filePath = req.file.location;

  if (filePath != null) {
    //console.log("PTH ", filePath)

    try {
      const mode = await User.changeAvatar(userId, filePath);
      res.status(200).json({
        status: "success",
        message: "Profile photo updated successfully",
        data: mode,
      });
    } catch (error) {
      res
        .status(500)
        .json({ status: "error", message: "Failed to upload photo" });
    }
  } else {
    res.status(400).send({
      status: "error",
      message: "No image found",
      data: null,
    });
  }
};

exports.updateBio = async (req, res) => {
  const userId = req.user.id;

  try {
    const mode = await User.updateBio(userId, req.body);
    res.status(200).json({
      status: "success",
      message: "Bio updated successfully",
      data: mode,
    });
  } catch (error) {
    res.status(500).json({ status: "error", message: "Failed to update bio" });
  }
};

exports.changePassword = async (req, res) => {
  const userId = req.user.id; //parseInt(req.params.id);
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
        .json({ status: "error", message: "Password reset failed." });
    }
  } else {
    return res.status(400).send({
      status: "error",
      message: "missing parameters",
      data: null,
    });
  }
};

exports.nearByUsers = async (req, res) => {
  const userId = req.user.id;
  const lat = req.params.lat;
  const lon = req.params.lon;
  const rad = req.params.radius ? req.params.radius : 5;

  if (!lat || !lon) {
    return res.status(400).send({
      status: "error",
      message: "Latitude and longitude are required",
      data: null,
    });
  }

  try {
    const users = await User.findNearbyUsers(
      parseFloat(lat),
      parseFloat(lon),
      parseFloat(rad)
    );

    if (users && users.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Nearby users retrieved successful",
        data: users,
      });
    } else {
      res.status(200).json({
        status: "success",
        message: "No nearby user found",
        data: null,
      });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error fetching nearby users", error: error.message });
  }
};

exports.nearByUsersByAddress = async (req, res) => {
  const userId = req.user.id;
  const address = req.params.address;

  if (!address) {
    return res.status(400).send({
      status: "error",
      message: "Address are required",
      data: null,
    });
  }

  try {
    const users = await User.findNearbyUsersByAddress(address);
    if (users && users.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Nearby users retrieved successful",
        data: users,
      });
    } else {
      res.status(200).json({
        status: "success",
        message: "No nearby user found",
        data: null,
      });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error fetching nearby users", error: error.message });
  }
};

exports.getAllusers = async (req, res) => {
  const userId = req.user.id;

  try {
    const users = await User.getAllusers();
    if (users && users.length > 0) {
      res.status(200).json({
        status: "success",
        message: "users retrieved successful",
        data: users,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No user found", data: null });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error fetching users", error: error.message });
  }
};

exports.generateReferralCode = async (req, res) => {
  const userId = req.user.id;
  const code = Math.floor(1000 + Math.random() * 900000);
  const referralCode = `skv${code}`;

  try {
    const users = await User.setReferralCode(userId, referralCode);
    res.status(200).json({
      status: "success",
      message: "user referral code updated successful",
      data: users,
    });
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error updateing referral code", error: error.message });
  }
};

exports.getReferredUsers = async (req, res) => {
  const code = req.params.code;

  try {
    const users = await User.getUsersByReferralCode(code);
    if (users && users.length > 0) {
      res.status(200).json({
        status: "success",
        message: "users retrieved successful",
        data: users,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No user found", data: null });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error fetching users", error: error.message });
  }
};

exports.getUserNotifications = async (req, res) => {
  const userId = req.user.id;

  try {
    const noti = await User.getUserNotifications(userId);
    if (noti && noti.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Notifications successful",
        data: noti,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No record found", data: null });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error fetching Notifications", error: error.message });
  }
};

// exports.createStripeAccount = async (req, res) => {
//   const userId = req.user.id;
//   const email = req.user.email;

//   if (userId != null) {
//     try {
//       const check = await StripeAccount.createStripeAccount(userId);

//       if (check == null) {
//         const account = await createConnectedAccount(email);

//         if (account) {
//           const user = await StripeAccount.createStripeAccount(
//             userId,
//             account.id
//           );
//           res.status(201).json({
//             status: "success",
//             message: "Stripe account created successfully.",
//             data: user,
//           });
//         }
//       } else {
//         res.status(400).json({
//           status: "error",
//           message: "User already has a stripe account",
//           data: null,
//         });
//       }
//     } catch (error) {
//       console.error("Stripe account creation error:", error);
//       res.status(500).json({
//         status: "error",
//         message: "Account creation failed.",
//         data: error.message || error, // More helpful
//       });
//     }
//   }
// };

// exports.generateStripeAccountLink = async (req, res) => {
//   console.log("Request Body:", req.body); // 👀 Debugging line

//   res.setHeader("Access-Control-Allow-Origin", "*"); // ✅ Allow all origins (for testing)
//   res.setHeader(
//     "Access-Control-Allow-Methods",
//     "GET, POST, PUT, DELETE, OPTIONS"
//   );
//   res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

//   const userId = req.user.id;
//   const { stripeAccountId } = req.body;

//   if (stripeAccountId != null) {
//     try {
//       const account = await generateAccountLink(stripeAccountId);

//       if (account) {
//         res.status(200).json({
//           status: "success",
//           message: "Onboarding link generated successfully",
//           data: account,
//         });
//       }
//     } catch (error) {
//       res.status(500).json({
//         status: "error",
//         message: "Failed to generate onboarding link",
//         data: error.detail,
//       });
//     }
//   } else {
//     res
//       .status(400)
//       .json({ status: "error", message: "Account is required", data: null });
//   }
// };
exports.createStripeAccount = async (req, res) => {
  const userId = req.user.id;
  const email = req.user.email;

  if (userId != null) {
    try {
      // ✅ First check if user already has a stripe account
      const check = await StripeAccount.findByUserId(userId);

      if (!check) {
        // ✅ Create Stripe connected account
        const account = await createConnectedAccount(email);

        if (account) {
          // ✅ Now save to MongoDB with both userId and account.id
          const userStripeAccount = await StripeAccount.createStripeAccount(
            userId,
            account.id
          );

          res.status(201).json({
            status: "success",
            message: "Stripe account created successfully.",
            data: userStripeAccount,
          });
        } else {
          res.status(500).json({
            status: "error",
            message: "Stripe account creation with Stripe failed.",
            data: null,
          });
        }
      } else {
        res.status(400).json({
          status: "error",
          message: "User already has a stripe account",
          data: null,
        });
      }
    } catch (error) {
      console.error("Stripe account creation error:", error);
      res.status(500).json({
        status: "error",
        message: "Account creation failed.",
        data: error.message || error,
      });
    }
  } else {
    res.status(400).json({
      status: "error",
      message: "User ID is missing",
    });
  }
};

exports.generateStripeAccountLink = async (req, res) => {
  console.log("Request Body:", req.body); // ✅ Debugging line

  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, POST, PUT, DELETE, OPTIONS"
  );
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

  const userId = req.user.id;
  const { stripeAccountId } = req.body;

  if (stripeAccountId != null) {
    try {
      console.log("Generating account link for:", stripeAccountId); // ✅ Debug before calling function

      const account = await generateAccountLink(stripeAccountId);

      console.log("Account link generated:", account); // ✅ Debug after calling function

      if (account) {
        res.status(200).json({
          status: "success",
          message: "Onboarding link generated successfully",
          data: account,
        });
      }
    } catch (error) {
      console.error("Error generating account link:", error); // Log any errors
      res.status(500).json({
        status: "error",
        message: "Failed to generate onboarding link",
        data: error.message,
      });
    }
  } else {
    res
      .status(400)
      .json({ status: "error", message: "Account is required", data: null });
  }
};

exports.processSplitPayment = async (req, res) => {
  const userId = req.user.id;
  const { amount, currency, stripeAccountId, customerEmail, paymentMethod } =
    req.body;

  try {
    if (paymentMethod === "wallet" || paymentMethod === "spark_token") {
      const userWallet = await Wallet.findOne({ userId });

      if (!userWallet) {
        return res.status(404).json({ message: "Wallet not found" });
      }

      const currentBalance =
        paymentMethod === "wallet"
          ? userWallet.balance
          : userWallet.spark_tokens;

      if (currentBalance < amount) {
        return res
          .status(400)
          .json({ message: "Insufficient balance in wallet." });
      }

      if (paymentMethod === "wallet") {
        userWallet.balance -= amount;
      } else if (paymentMethod === "spark_token") {
        userWallet.spark_tokens -= amount;
      }

      userWallet.updatedAt = new Date();

      await userWallet.save();

      return res.status(200).json({
        status: "success",
        message: `Payment of £${amount} made from ${paymentMethod.replace(
          "_",
          " "
        )}.`,
      });
    }

    if (paymentMethod === "stripe") {
      const paymentIntent = await processSplitPayment(
        customerEmail,
        amount,
        currency,
        stripeAccountId
      );

      if (paymentIntent) {
        return res.status(200).json({
          status: "success",
          message: "Stripe Payment Intent Created",
          data: paymentIntent,
        });
      }
    }

    return res.status(400).json({ message: "Invalid payment method" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      message: "Payment processing failed",
      error: err.message,
    });
  }
};

// ✅ New Controller: Create onboarding link for connected account
exports.createOnboardingLink = async (req, res) => {
  const { connectedAccountId } = req.body;

  if (!connectedAccountId) {
    return res
      .status(400)
      .json({ message: "Connected account ID is required." });
  }

  try {
    const accountLink = await stripe.accountLinks.create({
      account: connectedAccountId,
      refresh_url: "https://skilloviaweb.vercel.app/reauth", // change to your frontend reauth URL
      return_url: "https://skilloviaweb.vercel.app/success", // change to your frontend success URL
      type: "account_onboarding",
    });

    return res.status(200).json({ url: accountLink.url });
  } catch (error) {
    console.error("❌ Error creating onboarding link:", error);
    return res.status(500).json({
      message: "Failed to generate onboarding link",
      error: error.message,
    });
  }
};

exports.updateStripeAccount = async (req, res) => {
  const { chargesEnabled, payoutsEnabled, detailsSubmitted, stripeAccountId } =
    req.body;

  try {
    const account = await User.updateStripeAccount(
      chargesEnabled,
      payoutsEnabled,
      detailsSubmitted,
      stripeAccountId
    );
    res.status(200).json({
      status: "success",
      message: "Stripe account updated successfully",
      data: account,
    });
  } catch (error) {
    res
      .status(500)
      .json({ status: "error", message: "Failed to update Stripe account" });
  }
};

exports.deleteStripeAccount = async (req, res) => {
  const id = parseInt(req.params.id);

  try {
    const mode = await User.deleteStripeAccount(id);
    res.status(200).json({
      status: "success",
      message: "Account deleted successfully.",
      data: mode,
    });
  } catch (error) {
    res
      .status(500)
      .json({ status: "error", message: "Failed to delete account." });
  }
};

exports.getUserStripeAccount = async (req, res) => {
  const userId = parseInt(req.params.userId);

  if (userId != null) {
    try {
      const check = await User.checkStripeAccountExist(userId);

      if (check != null) {
        res.status(200).json({
          status: "success",
          message: "Stripe account retrieved successfully.",
          data: check,
        });
      } else {
        res.status(400).json({
          status: "error",
          message: "No stripe account found for this user",
          data: null,
        });
      }
    } catch (error) {
      res.status(500).json({
        status: "error",
        message: "Account retrieval failed.",
        data: error.detail,
      });
    }
  }
};
