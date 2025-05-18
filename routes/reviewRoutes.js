const express = require("express");
const router = express.Router();
const verify = require("../middlewares/verifyToken");
const {
  createReview,
  getReviewsForUser,
} = require("../controllers/reviewController");

// POST a review (after booking)
router.post("/", verify, createReview);

// GET all reviews for a user
router.get("/user/:id", verify, getReviewsForUser);

module.exports = router;
