const express = require('express');
const { registerUser, login, refreshToken, refreshTokenWeb, resetPassword, verifyPhone, sendVerificationCode} = require('../controllers/authController');
const passport = require('passport');
const router = express.Router();


router.post('/register', registerUser);
router.post('/login', login);
router.get('/get/refreshtoken', refreshToken);
router.get('/get/refreshtokenweb', refreshTokenWeb);
router.put('/reset/password/:id', resetPassword);
router.put('/reset/password', resetPassword);
router.post('/sendverificationcode', sendVerificationCode);
router.post('/verifyphone', verifyPhone);

// Redirect to Google for authentication
router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

// Callback route for Google to redirect to
router.get(
    '/google/callback',
    passport.authenticate('google', { failureRedirect: '/login' }),
    (req, res) => {
        const token = req.user.token;
        res.status(200).json({
            status: 'success',
            message: 'Login was successful',
            data: {accessToken: token, refreshToken:token},
        });
    }
);

module.exports = router;
