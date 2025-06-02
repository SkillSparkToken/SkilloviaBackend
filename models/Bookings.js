const mongoose = require("mongoose");

const bookingSchema = new mongoose.Schema(
  {
    skills_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Skill",
      required: true,
    },
    booking_user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    booked_user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    title: { type: String, required: true },
    description: { type: String },
    booking_location: { type: String },
    booking_date: { type: Date },
    thumbnail01: { type: String },
    thumbnail02: { type: String },
    thumbnail03: { type: String },
    thumbnail04: { type: String },
    file_url: { type: String },
    status: { type: String, default: "pending" }, // example default status
  },
  { timestamps: true }
);

// Assuming you have a Notification model
const Notification = require("./Notifications"); // update path as needed

bookingSchema.statics.createBooking = async function (userId, data, file) {
  const {
    skills_id,
    booked_user_id,
    title,
    description,
    booking_location,
    booking_date,
    thumbnails = {},
  } = data;

  const booking = new this({
    skills_id,
    booking_user_id: userId,
    booked_user_id,
    title,
    description,
    booking_location,
    booking_date,
    thumbnail01: thumbnails.thumbnail01,
    thumbnail02: thumbnails.thumbnail02,
    thumbnail03: thumbnails.thumbnail03,
    thumbnail04: thumbnails.thumbnail04,
    file_url: file,
  });

  const savedBooking = await booking.save();

  // Create notifications for both users
  await Notification.insertMany([
    {
      user_id: userId,
      title: "Booking Created",
      description: `Your booking for "${title}" is pending.`,
    },
    {
      user_id: booked_user_id,
      title: "New Booking Received",
      description: `Someone has booked your skill: "${title}".`,
    },
  ]);

  return savedBooking;
};

bookingSchema.statics.updateBooking = async function (id, updates, file) {
  const updateData = {
    ...updates,
    file_url: file || updates.file_url,
  };

  const updatedBooking = await this.findByIdAndUpdate(
    id,
    { $set: updateData },
    { new: true }
  );

  return updatedBooking;
};

bookingSchema.statics.changeStatus = async function (id, status) {
  const updatedBooking = await this.findByIdAndUpdate(
    id,
    { $set: { status } },
    { new: true }
  );
  return updatedBooking;
};

bookingSchema.statics.getInwardBookingsByUserId = async function (userId) {
  return await this.find({ booked_user_id: userId }).exec();
};

bookingSchema.statics.getOutwardBookingsByUserId = async function (userId) {
  return await this.find({ booking_user_id: userId }).exec();
};

bookingSchema.statics.deleteBooking = async function (userId, id) {
  // Deletes booking where id matches and user is booking user
  const deleted = await this.findOneAndDelete({
    _id: id,
    booking_user_id: userId,
  });
  return deleted;
};

const Booking = mongoose.model("Booking", bookingSchema);

module.exports = Booking;
