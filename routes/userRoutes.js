const express = require('express');
const { updateUser, changeAppearanceMode, changeNotificationType, getProfileByUserId} = require('../controllers/userController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")

router.put('/update/:id', verify, updateUser);
router.put('/settings/appearance', verify, changeAppearanceMode);
router.put('/settings/notification', verify, changeNotificationType);

router.get('/profile/:id', verify, getProfileByUserId);

module.exports = router;
