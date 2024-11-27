const express = require('express');
const {createSkill, updateSkill, deleteSkill} = require('../controllers/skillController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")

router.post('/', verify, createSkill);
router.put('/:id', verify, updateSkill);
router.delete('/:id', verify, deleteSkill);

module.exports = router;
