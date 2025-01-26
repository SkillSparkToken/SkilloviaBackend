const express = require('express');
const { registerUser, login, refreshToken, refreshTokenWeb, resetPassword, verifyPhone, sendVerificationCode, verifyEmail, resendEmailVerirficationCode, adminDelete} = require('../controllers/authController');
const passport = require('passport');
const router = express.Router();
const { getClientIp } = require('../middlewares/ipgetter');


router.post('/register', registerUser);
router.post('/login', getClientIp, login);
router.delete('/user/:email', adminDelete);
router.get('/get/refreshtoken', refreshToken);
router.get('/get/refreshtokenweb', refreshTokenWeb);
router.put('/reset/password/:id', resetPassword);
router.put('/reset/password', resetPassword);
router.post('/sendverificationcode', sendVerificationCode);
router.post('/verifyphone', verifyPhone);
router.post('/verify/email', verifyEmail);
router.post('/resend/code', resendEmailVerirficationCode);


// Redirect to Google for authentication
router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

// Callback route for Google to redirect to
router.get(
    '/google/callback',
    passport.authenticate('google', { failureRedirect: '/login' }),
    (req, res) => {
        const token = req.user.token;
        /* res.status(200).json({
            status: 'success',
            message: 'Login was successful',
            data: {accessToken: token, refreshToken:token},
        }); */

        res.redirect(`/explore?accessToken=${token}&refreshToken=${token}`);
    }
);

module.exports = router;
