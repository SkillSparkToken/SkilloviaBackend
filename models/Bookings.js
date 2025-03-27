const pool = require("../config/db");
const bcrypt = require("bcrypt");

class Booking {
  // static async create(userId, data, file) {
  //     const { skills_id, booked_user_id, title, description, booking_location, booking_date } = data;

  //     const result = await pool.query(
  //     'INSERT INTO bookings (skills_id, booking_user_id, booked_user_id, title, description, booking_location, booking_date, file_url) VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *',
  //     [skills_id, userId, booked_user_id, title, description, booking_location, booking_date, file]
  //     );

  //     return result.rows[0];
  // }

  static async create(userId, data, file) {
    const {
      skills_id,
      booked_user_id,
      title,
      description,
      booking_location,
      booking_date,
    } = data;

    const result = await pool.query(
      "INSERT INTO bookings (skills_id, booking_user_id, booked_user_id, title, description, booking_location, booking_date, file_url) VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *",
      [
        skills_id,
        userId,
        booked_user_id,
        title,
        description,
        booking_location,
        booking_date,
        file,
      ]
    );

    // 🔹 Create Notifications for Both Users
    await pool.query(
      `INSERT INTO notifications (user_id, title, description) VALUES
            ($1, $2, $3),  -- Notification for the person who booked
            ($4, $5, $6)   -- Notification for the skill owner
            `,
      [
        userId,
        "Booking Created",
        `Your booking for "${title}" is pending.`,

        booked_user_id,
        "New Booking Received",
        `Someone has booked your skill: "${title}".`,
      ]
    );

    return result.rows[0];
  }
  static async update(id, updates, file) {
    const { title, description, booking_location, booking_date } = updates;

    const result = await pool.query(
      `UPDATE bookings 
        SET title = COALESCE($1, title),
            description = COALESCE($2, description),
            booking_location = COALESCE($3, booking_location),
            booking_date = COALESCE($4, booking_date),
            file_url = COALESCE($5, file_url)
        WHERE id = $6 RETURNING *`,
      [title, description, booking_location, booking_date, file, id]
    );
    return result.rows[0];
  }

  static async changeStatus(id, status) {
    const result = await pool.query(
      `UPDATE bookings 
        SET status = COALESCE($1, status)
        WHERE id = $2 RETURNING *`,
      [status, id]
    );
    return result.rows[0];
  }

  static async getInwardBookingsByUserId(id) {
    const result = await pool.query(
      `
            SELECT 
                *
            FROM bookings
            WHERE booked_user_id = $1
            `,
      [id]
    );
    return result.rows;
  }

  static async getOutwardBookingsByUserId(id) {
    const result = await pool.query(
      `
            SELECT 
                *
            FROM bookings
            WHERE booking_user_id = $1
            `,
      [id]
    );
    return result.rows;
  }

  static async deleteBookings(userId, id) {
    const result = await pool.query(
      `DELETE FROM kyc 
             WHERE id = $1 AND booking_user_id = $2
             RETURNING *`,
      [id, userId]
    );

    return result.rows[0];
  }
}

module.exports = Booking;
