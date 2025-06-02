const mongoose = require("mongoose");

const notificationSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    description: String,
    markAsSeen: {
      type: String,
      enum: ["YES", "NO"],
      default: "NO",
    },
  },
  { timestamps: { createdAt: "createdAt", updatedAt: "updatedAt" } }
);

// Static methods
notificationSchema.statics.store = async function (userId, title, description) {
  const notification = new this({ userId, title, description });
  return await notification.save();
};

notificationSchema.statics.getAllNotifications = async function (userId) {
  return await this.find({ userId }).sort({ createdAt: -1 }).exec();
};

notificationSchema.statics.markAsSeen = async function (notificationId) {
  return await this.findByIdAndUpdate(
    notificationId,
    { markAsSeen: "YES" },
    { new: true }
  ).exec();
};

notificationSchema.statics.getBookingNotifications = async function (userId) {
  return await this.find({
    userId,
    title: { $in: ["Booking Created", "New Booking Received"] },
  })
    .sort({ createdAt: -1 })
    .exec();
};

notificationSchema.statics.getFollowNotifications = async function (userId) {
  return await this.find({
    userId,
    title: "New Follower",
  })
    .sort({ createdAt: -1 })
    .exec();
};

notificationSchema.statics.getFolloweeNotifications = async function (userId) {
  return await this.find({
    userId,
    title: "You Have a New Followee",
  })
    .sort({ createdAt: -1 })
    .exec();
};

const Notification = mongoose.model("Notification", notificationSchema);

module.exports = Notification;
