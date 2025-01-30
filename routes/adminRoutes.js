const express = require('express');
const { publishSkill, unPublishSkill, deleteSkill, retrievePublishedSkill, retrieveUnpublishedSkill,
    retrieveUserSkills, registerUser, updateUser, getAllusers, changeUserRole, approveKycStatus, rejectKycStatus,
    retrieveUserKyc, retrievePendingKyc, retrieveApprovedKyc, removeKyc
} = require('../controllers/adminController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")
const isAdmin = require("../middlewares/isAdmin")
const multer = require('multer');
const fs = require('fs');
const path = require('path');

router.put('/skills/publish/:id', verify, isAdmin, publishSkill);
router.put('/skills/unpublish/:id', verify, isAdmin, unPublishSkill);
router.delete('/skills/delete/:id', verify, isAdmin, deleteSkill);
router.get('/skills/get/published', verify, isAdmin, retrievePublishedSkill);
router.get('/skills/get/unpublished', verify, isAdmin, retrieveUnpublishedSkill);
router.get('/skills/user/:id', verify, isAdmin, retrieveUserSkills);

router.post('/users/create/account', verify, isAdmin, registerUser);
router.put('/users/update/account/:id', verify, isAdmin, updateUser);
router.get('/all/users', verify, isAdmin, getAllusers);
router.get('/users/get/all', verify, isAdmin, getAllusers);
router.put('/users/change/role/:user_id', verify, isAdmin, changeUserRole);

router.put('/kyc/approve/:id', verify, isAdmin, approveKycStatus);
router.put('/kyc/reject/:id', verify, isAdmin, rejectKycStatus);
router.get('/kyc/user/:user_id', verify, isAdmin, retrieveUserKyc);
router.get('/kyc/pending', verify, isAdmin, retrievePendingKyc);
router.get('/kyc/approved', verify, isAdmin, retrieveApprovedKyc);
router.delete('/kyc/delete/:id', verify, isAdmin, removeKyc);

module.exports = router;
