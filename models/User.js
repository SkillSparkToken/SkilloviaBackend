const pool = require('../config/db');
const bcrypt = require('bcrypt');

class User {
  static async create(phone, hashedPassword) {
    const result = await pool.query(
      'INSERT INTO users (phone, password) VALUES ($1, $2) RETURNING id, phone',
      [phone, hashedPassword]
    );
    return result.rows[0];
  }

  static async findByPhone(phone) {
    const result = await pool.query(
      'SELECT * FROM users WHERE phone = $1',
      [phone]
    );
    return result.rows[0];
  }

  static async update(userId, updates) {
    const { email, firstname, lastname, gender, password } = updates;
    const hashedPassword = password ? await bcrypt.hash(password, 10) : null;

    const result = await pool.query(
      `UPDATE users 
       SET email = COALESCE($1, email),
           firstname = COALESCE($2, firstname),
           lastname = COALESCE($3, lastname),
           gender = COALESCE($4, gender),
           password = COALESCE($5, password)
       WHERE id = $6 RETURNING *`,
      [email, firstname, lastname, gender, hashedPassword, userId]
    );
    return result.rows[0];
  }
}

module.exports = User;
