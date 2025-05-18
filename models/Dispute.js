const pool = require("../config/db");

class Dispute {
  static async create({ userId, bookingId, message, fileUrl }) {
    const result = await pool.query(
      `INSERT INTO disputes (user_id, booking_id, message, file_url)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [userId, bookingId, message, fileUrl]
    );

    return result.rows[0];
  }

  static async getByUser(userId) {
    const result = await pool.query(
      `SELECT * FROM disputes WHERE user_id = $1 ORDER BY created_at DESC`,
      [userId]
    );

    return result.rows;
  }

  static async getAll() {
    const result = await pool.query(
      `SELECT * FROM disputes ORDER BY created_at DESC`
    );
    return result.rows;
  }
}

module.exports = Dispute;
