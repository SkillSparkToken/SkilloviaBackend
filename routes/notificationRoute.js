const express = require("express");
const {
  getNotifications,
  getBookingNotifications,
  markNotificationAsSeen,
  getFolloweeNotifications,
  getFollowNotifications,
} = require("../controllers/notificationController");
const verify = require("../middlewares/verifyToken");
const router = express.Router();

router.get("/", verify, getNotifications);

// Get only booking notifications
router.get("/bookings", verify, getBookingNotifications);

router.get("/followees", verify, getFolloweeNotifications);

router.get("/follower", verify, getFollowNotifications);

// Mark a notification as seen
router.put("/:notificationId/seen", verify, markNotificationAsSeen);

module.exports = router;
