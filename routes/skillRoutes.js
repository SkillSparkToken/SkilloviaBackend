const express = require('express');
const {createSkill, updateSkill, deleteSkill, retrievePublishedSkill, searchSkillsByName, 
    searchSkillsByCreatorName, searchSkillsBySparktoken, updatePublishedStatus
} = require('../controllers/skillController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")

router.post('/', verify, createSkill);
router.put('/:id', verify, updateSkill);
router.delete('/:id', verify, deleteSkill);
router.put('/publish/:id', verify, updatePublishedStatus);
router.get('/', verify, retrievePublishedSkill);
router.get('/searchname/:term', verify, searchSkillsByName);
router.get('/searchcreator/:term', verify, searchSkillsByCreatorName);
router.get('/searchsparktoken/:term', verify, searchSkillsBySparktoken);


module.exports = router;
