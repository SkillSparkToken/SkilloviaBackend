const Notifications = require("../models/Notifications");

exports.storeNotification = async (userId, title, description) => {
  try {
    const notification = await Notifications.store(userId, title, description);
    return true

  } catch (error) {
    return 'Failed to store notifications';
  }
};

exports.getNotifications = async (req, res) => {
  try {
    const userId = req.user.id;
    const notifications = await Notifications.getAllNotifications(userId);

    res.status(200).json({
      status: "success",
      data: notifications,
    });
  } catch (error) {
    console.error("Error fetching notifications:", error);
    res.status(500).json({
      status: "error",
      message: "Failed to fetch notifications",
    });
  }
};

exports.getBookingNotifications = async (req, res) => {
  try {
    const userId = req.user.id;
    const bookingNotifications = await Notifications.getBookingNotifications(
      userId
    );

    res.status(200).json({
      status: "success",
      data: bookingNotifications,
    });
  } catch (error) {
    console.error("Error fetching booking notifications:", error);
    res.status(500).json({
      status: "error",
      message: "Failed to fetch booking notifications",
    });
  }
};

exports.markNotificationAsSeen = async (req, res) => {
  try {
    const { notificationId } = req.params;
    const updatedNotification = await Notifications.markAsSeen(notificationId);

    res.status(200).json({
      status: "success",
      message: "Notification marked as seen",
      data: updatedNotification,
    });
  } catch (error) {
    console.error("Error marking notification as seen:", error);
    res.status(500).json({
      status: "error",
      message: "Failed to update notification status",
    });
  }
};

exports.getFollowNotifications = async (req, res) => {
  try {
    const userId = req.user.id;
    const followNotifications = await Notifications.getFollowNotifications(
      userId
    );

    res.status(200).json({
      status: "success",
      data: followNotifications,
    });
  } catch (error) {
    console.error("Error fetching follow notifications:", error);
    res.status(500).json({
      status: "error",
      message: "Failed to fetch follow notifications",
    });
  }
};

exports.getFolloweeNotifications = async (req, res) => {
  try {
    const userId = req.user.id;
    const followeeNotifications = await Notifications.getFolloweeNotifications(
      userId
    );

    res.status(200).json({
      status: "success",
      data: followeeNotifications,
    });
  } catch (error) {
    console.error("Error fetching followee notifications:", error);
    res.status(500).json({
      status: "error",
      message: "Failed to fetch followee notifications",
    });
  }
};
