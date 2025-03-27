const Follows = require("../models/Follows");

// exports.followAccount = async (req, res) => {
//     const userId = req.user.id;
//     const follower_id = parseInt(req.params.follower_id);

//     try {
//         if(userId == follower_id){
//             res.status(400).json({ status: 'error', message: 'Cannot follow yourself', data: null });
//         } else {
//             const check = await Follows.checkFollower(userId, follower_id);
//             if(check == null){
//                 const user = await Follows.follow(userId, follower_id);
//                 res.status(200).json({ status: 'success', message: 'followed successfully.', data: user });
//             } else {
//                 res.status(200).json({ status: 'success', message: 'already following this account', data: null });
//             }
//         }
//     } catch (error) {
//         res.status(500).json({status: 'error', message: 'Failed to follow user.' });
//     }
// };

exports.followAccount = async (req, res) => {
  const userId = req.user.id; // The user who is following
  const follower_id = parseInt(req.params.follower_id); // The user being followed

  try {
    if (userId === follower_id) {
      return res
        .status(400)
        .json({
          status: "error",
          message: "Cannot follow yourself",
          data: null,
        });
    }

    const check = await Follows.checkFollower(userId, follower_id);
    if (!check) {
      const user = await Follows.follow(userId, follower_id);

      // 🔹 Create a notification for the followed user
      await pool.query(
        `INSERT INTO notifications (user_id, title, description) VALUES ($1, $2, $3)`,
        [follower_id, "New Follower", `User ${userId} started following you.`]
      );

      return res
        .status(200)
        .json({
          status: "success",
          message: "Followed successfully.",
          data: user,
        });
    } else {
      return res
        .status(200)
        .json({
          status: "success",
          message: "Already following this account",
          data: null,
        });
    }
  } catch (error) {
    console.error("Follow error:", error);
    return res
      .status(500)
      .json({ status: "error", message: "Failed to follow user." });
  }
};

exports.unfollowAccount = async (req, res) => {
  const userId = req.user.id;
  const follower_id = parseInt(req.params.follower_id);

  try {
    const user = await Follows.unfollow(userId, follower_id);
    res
      .status(200)
      .json({
        status: "success",
        message: "unfollowed successfully.",
        data: user,
      });
  } catch (error) {
    res
      .status(500)
      .json({ status: "error", message: "Failed to follow user." });
  }
};

exports.getFollowerList = async (req, res) => {
  const userId = req.user.id;

  try {
    const skill = await Follows.getFollowers(userId);
    res
      .status(200)
      .json({
        status: "success",
        message: "Followers retrieved successfully.",
        data: skill,
      });
  } catch (error) {
    res
      .status(500)
      .json({ status: "error", message: "Failed to retrieve followers" });
  }
};

exports.getFollowingList = async (req, res) => {
  const userId = req.user.id;

  try {
    const skill = await Follows.getFollowings(userId);
    res
      .status(200)
      .json({
        status: "success",
        message: "Followings retrieved successfully.",
        data: skill,
      });
  } catch (error) {
    res
      .status(500)
      .json({ status: "error", message: "Failed to retrieve followings" });
  }
};
