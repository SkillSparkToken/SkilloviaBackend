const mongoose = require("mongoose");

const skillSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    skill_type: { type: String, required: true },
    experience_level: String,
    hourly_rate: Number,
    spark_token: Number,
    description: String,
    approval_status: { type: String, default: "draft" },
    thumbnail01: String,
    thumbnail02: String,
    thumbnail03: String,
    thumbnail04: String,
  },
  { timestamps: true }
);

// Create a new skill and save it (published by default)
skillSchema.statics.createSkill = async function (userId, data) {
  const {
    skill_type,
    experience_level,
    hourly_rate,
    spark_token,
    description,
    thumbnails = {},
  } = data;

  const skill = new this({
    userId,
    skill_type,
    experience_level,
    hourly_rate,
    spark_token: spark_token ? parseInt(spark_token) : null,
    description,
    approval_status: "published",
    thumbnail01: thumbnails.thumbnail01,
    thumbnail02: thumbnails.thumbnail02,
    thumbnail03: thumbnails.thumbnail03,
    thumbnail04: thumbnails.thumbnail04,
  });

  return await skill.save();
};

// Retrieve all skills for a user with populated user info
skillSchema.statics.retrieveUserSkills = function (userId) {
  return this.find({ userId }).populate(
    "userId",
    "firstname lastname email photourl"
  );
};

skillSchema.statics.getSkillCategory = async function () {
  // Return all skill categories, no status filtering
  return this.find({});
};

// Update the approval status of a skill
skillSchema.statics.updatePublishedStatus = function (skillId, status) {
  return this.findByIdAndUpdate(
    skillId,
    { approval_status: status },
    { new: true }
  );
};

// Update skill partially by user and skillId
skillSchema.statics.updateSkill = function (userId, skillId, updates) {
  const updateFields = {
    skill_type: updates.skill_type,
    experience_level: updates.experience_level,
    hourly_rate: updates.hourly_rate,
    description: updates.description,
    thumbnail01: updates.thumbnails?.thumbnail01,
    thumbnail02: updates.thumbnails?.thumbnail02,
    thumbnail03: updates.thumbnails?.thumbnail03,
    thumbnail04: updates.thumbnails?.thumbnail04,
  };

  // Remove undefined fields (for partial update)
  Object.keys(updateFields).forEach(
    (key) => updateFields[key] === undefined && delete updateFields[key]
  );

  return this.findOneAndUpdate(
    { _id: skillId, userId },
    { $set: updateFields },
    { new: true }
  );
};

// Delete a skill by user and skillId
skillSchema.statics.deleteSkill = function (userId, skillId) {
  return this.findOneAndDelete({ _id: skillId, userId });
};

// Delete a specific thumbnail field by setting it to null
skillSchema.statics.deleteThumbnail = function (
  userId,
  skillId,
  thumbnailField
) {
  const update = {};
  update[thumbnailField] = null;
  return this.findOneAndUpdate(
    { _id: skillId, userId },
    { $set: update },
    { new: true }
  );
};

// Search published skills by skill_type (case insensitive partial match)
skillSchema.statics.searchBySkillType = function (skillType) {
  return this.find({
    skill_type: { $regex: skillType, $options: "i" },
  }).populate("userId", "firstname lastname email photourl");
};

// Search published skills by creator name (first or last name)
skillSchema.statics.searchByCreatorName = function (name) {
  // Note: Mongoose cannot query nested fields in populate directly in find,
  // so using aggregate for join-like behavior
  return this.aggregate([
    {
      $lookup: {
        from: "users",
        localField: "userId",
        foreignField: "_id",
        as: "user",
      },
    },
    { $unwind: "$user" },
    {
      $match: {
        approval_status: "published",
        $or: [
          { "user.firstname": { $regex: name, $options: "i" } },
          { "user.lastname": { $regex: name, $options: "i" } },
        ],
      },
    },
  ]);
};

// Search published skills by spark_token
skillSchema.statics.searchBySparkToken = function (token) {
  return this.find({
    spark_token: token,
    approval_status: "published",
  }).populate("userId", "firstname lastname email photourl");
};

// Find one skill by id and userId
skillSchema.statics.findSkillByIdAndUser = function (skillId, userId) {
  return this.findOne({ _id: skillId, userId });
};

// Get all published skills with user details
skillSchema.statics.getAllPublishedSkills = function () {
  return this.find({ approval_status: "published" }).populate(
    "userId",
    "firstname lastname email photourl"
  );
};

module.exports = mongoose.model("Skill", skillSchema);
