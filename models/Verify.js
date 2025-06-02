// models/verifyEmail.model.js
const mongoose = require("mongoose");

const verifyEmailSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  token: { type: String, required: true },
  createdAt: { type: Date, default: Date.now, expires: 3600 }, // auto-delete after 1 hour
});

// Static methods
verifyEmailSchema.statics.verifyUserEmail = async function (email, code) {
  return await this.findOne({ email, token: code });
};

verifyEmailSchema.statics.insertVerificationCode = async function (
  email,
  code
) {
  return await this.create({ email, token: code });
};

verifyEmailSchema.statics.updateVerificationCode = async function (
  email,
  code
) {
  return await this.findOneAndUpdate({ email }, { token: code }, { new: true });
};

verifyEmailSchema.statics.checkVerificationExist = async function (email) {
  return await this.findOne({ email });
};

module.exports = mongoose.model("verifyEmail", verifyEmailSchema);
