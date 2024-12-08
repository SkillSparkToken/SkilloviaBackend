const express = require('express');
const {followAccount, unfollowAccount, getFollowerList, getFollowingList} = require('../controllers/followController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")

router.post('/follow/:follower_id', verify, followAccount);
router.delete('/unfollow/:follower_id', verify, unfollowAccount);
router.get('/getfollowers', verify, getFollowerList);
router.get('/getfollowings', verify, getFollowingList);


module.exports = router;
