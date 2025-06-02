// models/SuggestSkill.js
const mongoose = require("mongoose");

const suggestSkillSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User", // assumes you have a User model
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    approval_status: {
      type: String,
      enum: ["pending", "approved", "rejected"],
      default: "pending",
    },
  },
  { timestamps: true }
);

// Static Methods

// Create a new suggested skill
suggestSkillSchema.statics.createSuggestion = async function (userId, data) {
  return await this.create({ userId, ...data });
};

// Update status of a suggested skill
suggestSkillSchema.statics.updateStatus = async function (id, updates) {
  const { status } = updates;
  return await this.findByIdAndUpdate(
    id,
    { approval_status: status },
    { new: true }
  );
};

// Delete a suggestion
suggestSkillSchema.statics.deleteSuggestion = async function (id) {
  return await this.findByIdAndDelete(id);
};

// Find a suggestion by name
suggestSkillSchema.statics.findSuggestedSkill = async function (name) {
  return await this.findOne({ name });
};

// Retrieve all suggestions by status with user info populated
suggestSkillSchema.statics.retrieveSuggestedSkills = async function (status) {
  return await this.find({ approval_status: status }).populate({
    path: "userId",
    select: "firstname lastname email", // adjust based on your User model
  });
};

// Find a suggestion by ID
suggestSkillSchema.statics.findSuggestedSkillById = async function (id) {
  return await this.findById(id);
};

const SuggestSkill = mongoose.model("SuggestSkill", suggestSkillSchema);

module.exports = SuggestSkill;
