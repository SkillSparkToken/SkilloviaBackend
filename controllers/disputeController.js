const Dispute = require("../models/Dispute");

exports.openDispute = async (req, res) => {
  const userId = req.user.id;
  const { bookingId, message } = req.body;

  if (!bookingId || !message) {
    return res.status(400).json({
      status: "error",
      message: "Booking ID and message are required",
    });
  }

  let fileUrl = null;
  if (req.file) {
    fileUrl = req.file.location; // S3 file URL
  }

  try {
    const dispute = await Dispute.create({
      userId,
      bookingId,
      message,
      fileUrl,
    });

    res.status(201).json({
      status: "success",
      message: "Dispute opened successfully.",
      data: dispute,
    });
  } catch (err) {
    console.error("Error opening dispute:", err);
    res.status(500).json({
      status: "error",
      message: "Failed to open dispute.",
    });
  }
};

exports.getUserDisputes = async (req, res) => {
  const userId = req.user.id;

  try {
    const disputes = await Dispute.getByUser(userId);
    res.status(200).json({ status: "success", data: disputes });
  } catch (err) {
    console.error("Error fetching disputes:", err);
    res
      .status(500)
      .json({ status: "error", message: "Failed to fetch disputes." });
  }
};

exports.getAllDisputes = async (req, res) => {
  try {
    const disputes = await Dispute.getAll();
    res.status(200).json({ status: "success", data: disputes });
  } catch (err) {
    console.error("Error fetching all disputes:", err);
    res
      .status(500)
      .json({ status: "error", message: "Failed to fetch disputes." });
  }
};
