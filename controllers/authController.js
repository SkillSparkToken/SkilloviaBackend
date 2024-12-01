const User = require('../models/User');
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");
const twilioConfig = require('../config/twilio');


// handles user registration
const registerUser = async (req, res) => {
  try {
    const user = await User.create(req.body);
    res.status(201).json({ status: 'success', message: 'User registered successfully.', data: user });
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Registration failed.', data: error });
  }
};


// handles user login
const login = async (req, res) => {
  const {email, phone, password} = req.body
  let today = new Date().toISOString().slice(0, 10)

  try {
    const user = await User.findByEmail(email);
    if(user != null){
      const validPass = await bcrypt.compare(password, user.password)
      if(!validPass) {
          return res.status(400).send({
              status: 'error',
              message: 'Invalid password',
              data: null
          }); 
      } 

      const accessToken = generateAccessToken({id:user.id, email:user.email, phone:user.phone});
      const refreshToken = jwt.sign({id:user.id, email:user.email, phone:user.phone}, process.env.REFRESH_TOKEN_SECRET);

      // Store refresh token
      const storereFreshToken = await User.storeRefreshToken(refreshToken);

      // Creates Secure Cookie with refresh token
      res.cookie('jwt', refreshToken, { httpOnly: true, secure: true, sameSite: 'None', maxAge: 24 * 60 * 60 * 1000 });

      res.status(200).send({
          status: 'success',
          message: 'Login was successful',
          data: {accessToken: accessToken, refreshToken:refreshToken}
      });
    } else {
      const user = await User.findByPhone(phone);

      if(user != null){
        const validPass = await bcrypt.compare(password, user.password)
        if(!validPass) {
            return res.status(400).send({
                status: 'error',
                message: 'Invalid password',
                data: null
            }); 
        } 
  
        const accessToken = generateAccessToken({id:user.id, email:user.email, phone:user.phone});
        const refreshToken = jwt.sign({id:user.id, email:user.email, phone:user.phone}, process.env.REFRESH_TOKEN_SECRET);
  
        // Store refresh token
        const storereFreshToken = await User.storeRefreshToken(refreshToken);
  
        // Creates Secure Cookie with refresh token
        res.cookie('jwt', refreshToken, { httpOnly: true, secure: true, sameSite: 'None', maxAge: 24 * 60 * 60 * 1000 });
  
        res.status(200).send({
            status: 'success',
            message: 'Login was successful',
            data: {accessToken: accessToken, refreshToken:refreshToken}
        });
      } else {
        res.status(400).send({
          status: 'error',
          message: 'Email/Phone or password is not correct',
          data: null
        });
      }
    }
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to login user.', data: error });
  }
}


const refreshToken = async (req, res) => {
  const refreshToken = req.body.token
  if (refreshToken == null) return res.sendStatus(401)

  const token = await User.getRefreshToken(refreshToken);
  if(token && token.length < 0) return res.sendStatus(403)

  jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (error, user) => {
      if(error) return res.sendStatus(403)
      const accessToken = generateLongLiveAccessToken({id:user.id, email:user.email, phone:user.phone})

      res.status(200).send({
          status: 'success',
          message: 'Refresh token retrieved successfully',
          data: { accessToken: accessToken }
      });
  })
}


const refreshTokenWeb = async (req, res) => {
  const cookies = req.cookies;
  if (!cookies.jwt) return res.sendStatus(401);
  const refreshToken = cookies.jwt;
  res.clearCookie('jwt', { httpOnly: true, sameSite: 'None', secure: true });

  const token = await User.getRefreshToken(refreshToken);
  if(token && token.length < 0) return res.sendStatus(403)

  jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (error, user) => {
      if(error) return res.json(error)
      const accessToken = generateLongLiveAccessToken({id:user.id, email:user.email, phone:user.phone})
      
      // Store refresh token
      const storereFreshToken = User.storeRefreshToken(accessToken);

      // Creates Secure Cookie with refresh token
      res.cookie('jwt', accessToken, { httpOnly: true, secure: true, sameSite: 'None', maxAge: 24 * 60 * 60 * 1000 });

      res.status(200).send({
          status: 'success',
          message: 'Refresh token retrieved successfully',
          data: {id: user.id, accessToken: accessToken }
      }); 
  })
}


const resetPassword = async (req, res) => {
  const userId = parseInt(req.params.id);
  const {password} = req.body

  try {
    const hashedPassword = password ? await bcrypt.hash(password, 10) : null;
    const user = await User.resetPassword(userId, hashedPassword);

    res.status(201).json({ status: 'success', message: 'Password reset was successful', data: user });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Registration failed.' });
  }
}


const sendVerificationCode = async (req, res) => {
  const { phone } = req.body;

  try {
    // Send a verification code
    const verification = await twilioConfig.sendVerificationCode(phone);
    if(verification.status == 'approved' || verification.status == 'pending'){
      res.status(200).json({status: 'success', message: 'Verification code sent.', data: verification });
    } else {
      res.status(400).json({ status: 'Twilio error', message: 'Failed to send verification code.', data: verification });
    }
    

  } catch (error) {
    console.error('Twilio Test Error:', error.message);
    res.status(400).json({ status: 'Twilio error', message: 'Failed to send verification code.', data: error.message });
  }
};


const verifyPhone = async (req, res) => {
  const { phone, code } = req.body;

  try {
    const isVerified = await twilioConfig.verifyCode(phone, code);

    if(isVerified == 'Success'){
      res.status(200).json({status: 'success', message: 'Verification was successful.', data: isVerified });
    } else if(isVerified == 'Failed'){
      res.status(400).json({status: 'failed', message: 'Verification was not successful.', data: isVerified });
    } else {
      res.status(400).json({ status: 'Twilio error', message: 'Failed to verify code.', data: isVerified });
    }

  } catch (error) {
    console.error('Twilio Test Error:', error.message);
    res.status(400).json({ status: 'Twilio error', message: 'Failed to verify code.', data: error.message });
  }
};


function generateAccessToken(user) {
  return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '600s'});
}


function generateLongLiveAccessToken(user) {
  return jwt.sign(user, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '365d' } );
}



module.exports = {
  registerUser,
  login,
  refreshToken,
  refreshTokenWeb,
  resetPassword,
  verifyPhone,
  sendVerificationCode,
}