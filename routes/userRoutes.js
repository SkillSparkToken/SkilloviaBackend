const express = require('express');
const { updateUser, changeAppearanceMode, changeNotificationType, getProfileByUserId, 
   profilePhotoUpload, profilePhotoUploadS3, updateBio, changePassword, nearByUsers, nearByUsers2} = require('../controllers/userController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")
const multer = require('multer');
const fs = require('fs');
const path = require('path');
//const uploads3 = require('../upload/index');


const storage = multer.diskStorage({
  destination: function (req, file, callback) {
     const uploadDir = '/uploads/profile';
     
     callback(null, __dirname + uploadDir);
  },
  filename: function (req, file, callback) {
     const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
     const filename = uniqueSuffix + path.extname(file.originalname);
     const filePath = path.join(__dirname + '/uploads/profile', filename); // Construct the file path

     // Store the file path in req
     if (!req.filePaths) {
        req.filePaths = null;
     }
     req.filePaths = filePath;

     callback(null, filename);
  }
});

const upload = multer({ storage: storage })

router.put('/update/:id', verify, updateUser);
router.put('/settings/appearance', verify, changeAppearanceMode);
router.put('/settings/notification', verify, changeNotificationType);

router.get('/profile/:id', verify, getProfileByUserId);
router.put('/profile/upload', verify, upload.single('photo'), profilePhotoUpload);
//router.put('/profile/upload/aws', verify, uploads3.single('photo'), profilePhotoUploadS3);
router.put('/profile/update/bio', verify, updateBio);
router.put('/change/password', verify, changePassword);
//router.get('/people/nearby', verify, nearByUsers2);
router.get('/people/nearby/:lat/:lon', verify, nearByUsers);

module.exports = router;
