const express = require('express');
const { updateUser, changeAppearanceMode, changeNotificationType } = require('../controllers/userController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")

router.put('/update/:id', verify, updateUser);
router.put('/settings/appearance', verify, changeAppearanceMode);
router.put('/settings/notification', verify, changeNotificationType);

module.exports = router;
