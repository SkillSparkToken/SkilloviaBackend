const mongoose = require("mongoose");

// Follow schema
const followSchema = new mongoose.Schema(
  {
    following_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    follower_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
  },
  { timestamps: true }
);

const Follow = mongoose.models.Follow || mongoose.model("Follow", followSchema);

// Static methods for follow actions

Follow.follow = async function (userId, follower_id) {
  const follow = new Follow({ following_id: userId, follower_id });
  return await follow.save();
};

Follow.unfollow = async function (userId, follower_id) {
  return await Follow.findOneAndDelete({
    following_id: userId,
    follower_id,
  }).exec();
};

Follow.checkFollower = async function (userId, follower_id) {
  return await Follow.findOne({ following_id: userId, follower_id }).exec();
};

Follow.getFollowers = async function (userId) {
  return await Follow.find({ following_id: userId })
    .populate("follower_id", "firstname lastname email photourl phone")
    .sort({ createdAt: -1 })
    .exec();
};

Follow.getFollowings = async function (userId) {
  return await Follow.find({ follower_id: userId })
    .populate("following_id", "firstname lastname email photourl phone")
    .sort({ createdAt: -1 })
    .exec();
};

module.exports = Follow;
