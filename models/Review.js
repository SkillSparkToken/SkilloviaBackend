const pool = require("../config/db");

// class Review {
//   static async create({ bookingId, reviewerId, revieweeId, rating, comment }) {
//     const result = await pool.query(
//       `INSERT INTO reviews (booking_id, reviewer_id, reviewee_id, rating, comment)
//        VALUES ($1, $2, $3, $4, $5) RETURNING *`,
//       [bookingId, reviewerId, revieweeId, rating, comment]
//     );
//     return result.rows[0];
//   }

//   static async getByBookingId(bookingId) {
//     const result = await pool.query(
//       `SELECT * FROM reviews WHERE booking_id = $1`,
//       [bookingId]
//     );
//     return result.rows;
//   }

//   static async getReviewsForUser(userId) {
//     const result = await pool.query(
//       `SELECT * FROM reviews WHERE reviewee_id = $1`,
//       [userId]
//     );
//     return result.rows;
//   }
// }
// models/Review.js

class Review {
  static async create({ skillId, reviewerId, revieweeId, rating, comment }) {
    const result = await pool.query(
      `INSERT INTO reviews (skill_id, reviewer_id, reviewee_id, rating, comment)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [skillId, reviewerId, revieweeId, rating, comment]
    );
    return result.rows[0];
  }

  static async getReviewsForUser(userId) {
    const result = await pool.query(
      `SELECT * FROM reviews WHERE reviewee_id = $1`,
      [userId]
    );
    return result.rows;
  }
}

module.exports = Review;
