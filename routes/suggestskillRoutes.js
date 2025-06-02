const express = require('express');
const {createSuggestSkill, updateStatus, deleteSuggestSkill, retrieveSuggestedSkills} = require('../controllers/suggestSkillControl');
const router = express.Router();
const verify = require("../middlewares/verifyToken")

router.post('/', verify, createSuggestSkill);
router.put('/:id', verify, updateStatus);
router.delete('/:id', verify, deleteSuggestSkill);
router.get('/bystatus/:status', verify, retrieveSuggestedSkills);


module.exports = router;
