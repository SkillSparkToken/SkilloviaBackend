const mongoose = require("mongoose");

const messageSchema = new mongoose.Schema(
  {
    senderId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    receiverId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    content: {
      type: String,
      required: true,
    },
    markAsRead: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: { createdAt: "createdAt", updatedAt: "updatedAt" } }
);

// Store a new message
messageSchema.statics.store = async function (data) {
  const message = new this(data);
  return await message.save();
};

// Retrieve messages between two users ordered by createdAt
messageSchema.statics.retrieveMessage = async function (senderId, receiverId) {
  return await this.find({
    $or: [
      { senderId, receiverId },
      { senderId: receiverId, receiverId: senderId },
    ],
  })
    .sort({ createdAt: 1 })
    .exec();
};

// Mark a message as read by ID
messageSchema.statics.markAsRead = async function (messageId) {
  return await this.findByIdAndUpdate(
    messageId,
    { markAsRead: true },
    { new: true }
  ).exec();
};

// Retrieve chat users with metadata for a specific user
messageSchema.statics.retrieveChatUsers = async function (userId) {
  // Aggregate to mimic your SQL query for chat users with unread count, last message, and last message time
  return await this.aggregate([
    {
      $match: {
        $or: [
          { senderId: mongoose.Types.ObjectId(userId) },
          { receiverId: mongoose.Types.ObjectId(userId) },
        ],
      },
    },
    {
      $project: {
        otherUserId: {
          $cond: [
            { $eq: ["$senderId", mongoose.Types.ObjectId(userId)] },
            "$receiverId",
            "$senderId",
          ],
        },
        content: 1,
        createdAt: 1,
        markAsRead: 1,
      },
    },
    {
      $sort: { createdAt: -1 },
    },
    {
      $group: {
        _id: "$otherUserId",
        lastMessage: { $first: "$content" },
        lastMessageTime: { $first: "$createdAt" },
        unreadMessageCount: {
          $sum: {
            $cond: [
              {
                $and: [
                  { $eq: ["$receiverId", mongoose.Types.ObjectId(userId)] },
                  { $eq: ["$markAsRead", false] },
                ],
              },
              1,
              0,
            ],
          },
        },
      },
    },
    {
      $lookup: {
        from: "users",
        localField: "_id",
        foreignField: "_id",
        as: "user",
      },
    },
    {
      $unwind: "$user",
    },
    {
      $project: {
        user_id: "$_id",
        name: { $concat: ["$user.firstname", " ", "$user.lastname"] },
        email: "$user.email",
        photourl: "$user.photourl",
        unreadMessageCount: 1,
        lastMessage: 1,
        lastMessageTime: 1,
      },
    },
    {
      $sort: { lastMessageTime: -1 },
    },
  ]).exec();
};

const Message = mongoose.model("Message", messageSchema);

module.exports = Message;
