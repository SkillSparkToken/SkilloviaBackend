const mongoose = require("mongoose");

const disputeSchema = new mongoose.Schema(
  {
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    booking_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Booking",
      required: true,
    },
    message: { type: String, required: true },
    file_url: { type: String },
  },
  { timestamps: true }
);

disputeSchema.statics.createDispute = async function ({
  userId,
  bookingId,
  message,
  fileUrl,
}) {
  const dispute = new this({
    user_id: userId,
    booking_id: bookingId,
    message,
    file_url: fileUrl,
  });
  return await dispute.save();
};

disputeSchema.statics.getByUser = async function (userId) {
  return await this.find({ user_id: userId }).sort({ createdAt: -1 }).exec();
};

disputeSchema.statics.getAll = async function () {
  return await this.find().sort({ createdAt: -1 }).exec();
};

const Dispute = mongoose.model("Dispute", disputeSchema);

module.exports = Dispute;
