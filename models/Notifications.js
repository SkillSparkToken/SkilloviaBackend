const pool = require("../config/db");

class Notifications {
  // Store a new notification
  static async store(userId, title, description) {
    const result = await pool.query(
      `INSERT INTO notifications (user_id, title, description) 
             VALUES ($1, $2, $3) RETURNING *`,
      [userId, title, description]
    );
    return result.rows[0];
  }

  // Get all notifications for a specific user
  static async getAllNotifications(userId) {
    const result = await pool.query(
      `SELECT * FROM notifications 
             WHERE user_id = $1 
             ORDER BY created_at DESC`,
      [userId]
    );
    return result.rows;
  }

  // Mark notification as seen
  static async markAsSeen(notificationId) {
    const result = await pool.query(
      `UPDATE notifications 
             SET mark_as_seen = 'YES' 
             WHERE id = $1 
             RETURNING *`,
      [notificationId]
    );
    return result.rows[0];
  }

  // Get all booking-related notifications for a user
  static async getBookingNotifications(userId) {
    const result = await pool.query(
      `SELECT * FROM notifications 
             WHERE user_id = $1 AND (title = 'Booking Created' OR title = 'New Booking Received') 
             ORDER BY created_at DESC`,
      [userId]
    );
    return result.rows;
  }

  static async getFollowNotifications(userId) {
    const result = await pool.query(
      `SELECT * FROM notifications 
       WHERE user_id = $1 AND title = 'New Follower' 
       ORDER BY created_at DESC`,
      [userId]
    );
    return result.rows;
  }

  // Get all followee notifications for a specific user
  static async getFolloweeNotifications(userId) {
    const result = await pool.query(
      `SELECT * FROM notifications 
       WHERE user_id = $1 AND title = 'You Have a New Followee' 
       ORDER BY created_at DESC`,
      [userId]
    );
    return result.rows;
  }
}

module.exports = Notifications;
