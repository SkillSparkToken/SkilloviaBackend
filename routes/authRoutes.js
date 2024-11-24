const express = require('express');
const { registerUser, login, refreshToken, refreshTokenWeb, resetPassword} = require('../controllers/authController');
const router = express.Router();


router.post('/register', registerUser);
router.post('/login', login);
router.get('/get/refreshtoken', refreshToken);
router.get('/get/refreshtokenweb', refreshTokenWeb);
router.put('/reset/password/:id', resetPassword);

module.exports = router;
