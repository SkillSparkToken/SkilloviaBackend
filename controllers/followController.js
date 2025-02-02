const Follows = require('../models/Follows');

exports.followAccount = async (req, res) => {
    const userId = req.user.id;
    const follower_id = parseInt(req.params.follower_id);

    try {
        if(userId == follower_id){
            res.status(400).json({ status: 'error', message: 'Cannot follow yourself', data: null });
        } else {
            const check = await Follows.checkFollower(userId, follower_id);
            if(check == null){
                const user = await Follows.follow(userId, follower_id);
                res.status(200).json({ status: 'success', message: 'followed successfully.', data: user });
            } else {
                res.status(200).json({ status: 'success', message: 'already following this account', data: null });
            }
        }
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to follow user.' });
    }
};


exports.unfollowAccount = async (req, res) => {
    const userId = req.user.id;
    const follower_id = parseInt(req.params.follower_id);

    try {
        const user = await Follows.unfollow(userId, follower_id);
        res.status(200).json({ status: 'success', message: 'unfollowed successfully.', data: user });
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to follow user.' });
    }
};


exports.getFollowerList = async (req, res) => {
    const userId = req.user.id;  

    try {
        const skill = await Follows.getFollowers(userId);
        res.status(200).json({ status: 'success', message: 'Followers retrieved successfully.', data: skill });
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to retrieve followers' });
    }
};


exports.getFollowingList = async (req, res) => {
    const userId = req.user.id;  

    try {
        const skill = await Follows.getFollowings(userId);
        res.status(200).json({ status: 'success', message: 'Followings retrieved successfully.', data: skill });
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to retrieve followings' });
    }
};
