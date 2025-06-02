const mongoose = require("mongoose");

const reviewSchema = new mongoose.Schema(
  {
    skillId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Skill",
      required: true,
    },
    reviewerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    revieweeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    rating: {
      type: Number,
      required: true,
      min: 1,
      max: 5,
    },
    comment: {
      type: String,
    },
  },
  { timestamps: true }
);

const Review = mongoose.model("Review", reviewSchema);

class ReviewModel {
  static async create({ skillId, reviewerId, revieweeId, rating, comment }) {
    const review = new Review({
      skillId,
      reviewerId,
      revieweeId,
      rating,
      comment,
    });
    return await review.save();
  }

  static async getReviewsForUser(userId) {
    return await Review.find({ revieweeId: userId }).exec();
  }
}

module.exports = ReviewModel;
