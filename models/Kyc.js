const mongoose = require("mongoose");

const kycSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    kyc_method: {
      type: String,
      required: true,
    },
    kyc_id_type: {
      type: String,
      required: true,
    },
    document_url: {
      type: String,
      required: true,
    },
    approval_status: {
      type: String,
      default: "pending", // example default
    },
  },
  { timestamps: true }
);

// Upload new KYC document
kycSchema.statics.upload = async function (userId, method, type, file) {
  const kyc = new this({
    userId,
    kyc_method: method,
    kyc_id_type: type,
    document_url: file,
  });
  return await kyc.save();
};

// Re-upload / update KYC document by id with optional updates
kycSchema.statics.reupload = async function (id, updates) {
  const updated = await this.findByIdAndUpdate(
    id,
    {
      $set: {
        ...(updates.kyc_method && { kyc_method: updates.kyc_method }),
        ...(updates.kyc_id_type && { kyc_id_type: updates.kyc_id_type }),
        ...(updates.document_url && { document_url: updates.document_url }),
      },
    },
    { new: true }
  );
  return updated;
};

// Change approval status by id
kycSchema.statics.changeStatus = async function (id, status) {
  const updated = await this.findByIdAndUpdate(
    id,
    { approval_status: status },
    { new: true }
  );
  return updated;
};

// Get all KYC docs by userId
kycSchema.statics.getKycByUserId = async function (userId) {
  return await this.find({ userId }).exec();
};

// Get KYC docs by method and approval status, populated with user info
kycSchema.statics.getKycs = async function (method, status) {
  return await this.find({ kyc_method: method, approval_status: status })
    .populate("userId", "firstname lastname email phone gender") // adjust fields as needed
    .exec();
};

// Get KYC docs by userId and method
kycSchema.statics.getUserKyc = async function (userId, method) {
  return await this.find({ userId, kyc_method: method }).exec();
};

// Delete KYC doc by id, userId and method
kycSchema.statics.deleteKyc = async function (userId, id, method) {
  return await this.findOneAndDelete({
    _id: id,
    userId,
    kyc_method: method,
  }).exec();
};

const Kyc = mongoose.model("Kyc", kycSchema);

module.exports = Kyc;
