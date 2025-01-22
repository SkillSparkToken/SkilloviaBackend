const express = require('express');
const {  createSkill, 
   updateSkill, 
   deleteSkill, 
   retrievePublishedSkill, 
   searchSkillsByName, 
   searchSkillsByCreatorName, 
   searchSkillsBySparktoken, 
   updatePublishedStatus, 
   retrieveUserSkill,
   deleteSkillPhoto,
   searchSkillsByType
} = require('../controllers/skillController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")
const multer = require('multer');
const fs = require('fs');
const path = require('path');


const storage = multer.diskStorage({
  destination: function (req, file, callback) {
     const uploadDir = '/uploads/skills';
     
     callback(null, __dirname + uploadDir);
  },
  filename: function (req, file, callback) {
     const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
     const filename = uniqueSuffix + path.extname(file.originalname);
     const filePath = path.join(__dirname + '/uploads/skills', filename);

     // Store the file path in req
     if (!req.filePaths) {
        req.filePaths = null;
     }
     req.filePaths = filePath;

     callback(null, filename);
  }
});

const upload = multer({ storage: storage })


router.post('/', verify, upload.array('thumbnails', 4), createSkill);
router.put('/:id', verify, upload.array('thumbnails', 4), updateSkill);
router.delete('/:id', verify, deleteSkill);
router.put('/publish/:id', verify, updatePublishedStatus);
router.get('/', verify, retrievePublishedSkill);
router.get('/searchname/:term', verify, searchSkillsByName);
router.get('/searchcreator/:term', verify, searchSkillsByCreatorName);
router.get('/searchsparktoken/:term', verify, searchSkillsBySparktoken);
router.get('/search/type/:term', verify, searchSkillsByType);
router.get('/user/all', verify, retrieveUserSkill);
router.delete('/photo/:id', verify, deleteSkillPhoto);

module.exports = router;
