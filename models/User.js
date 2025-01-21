const pool = require('../config/db');
const bcrypt = require('bcrypt');

class User {
  static async create(data) {
    const {phone, email, firstname, lastname, gender, password } = data;
    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      'INSERT INTO users (phone, email, firstname, lastname, gender, password) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *',
      [phone, email, firstname, lastname, gender, hashedPassword]
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


  static async findByPhone(phone) {
    const result = await pool.query(
      'SELECT * FROM users WHERE phone = $1',
      [phone]
    );
    return result.rows[0];
  }


  static async findByEmail(email) {
    const result = await pool.query(
      'SELECT * FROM users WHERE email = $1',
      [email]
    );
    return result.rows[0];
  }


  static async findById(id) {
    const result = await pool.query(
      'SELECT * FROM users WHERE id = $1',
      [id]
    );
    return result.rows[0];
  }


  static async storeRefreshToken(token) {
    const result = await pool.query(
      'INSERT INTO refreshtoken (token) VALUES ($1) RETURNING token',
      [token]
    );
    return result.rows[0];
  }


  static async getRefreshToken(token) {
    const result = await pool.query(
      'SELECT * FROM refreshtoken WHERE token = $1',
      [token]
    );
    return result.rows[0];
  }


  static async resetPassword(userId, password) {
    const result = await pool.query(
      `UPDATE users 
       SET password = COALESCE($1, password)
       WHERE id = $2 RETURNING *`,
      [password, userId]
    );
    return result.rows[0];
  }


  static async changeNotificationType(userId, type) {
    const result = await pool.query(
      `UPDATE users 
       SET notification_type = COALESCE($1, notification_type)
       WHERE id = $2 RETURNING *`,
      [type, userId]
    );
    return result.rows[0];
  }


  static async changeAppearanceMode(userId, mode) {
    const result = await pool.query(
      `UPDATE users 
       SET appearance_mode = COALESCE($1, appearance_mode)
       WHERE id = $2 RETURNING *`,
      [mode, userId]
    );
    return result.rows[0];
  }


  static async getProfileByUserId(id) {
    const result = await pool.query(
        `
        SELECT 
            users.*, 
            skills.description AS description,
            skills.skill_type AS skill_type,
            skills.experience_level AS experience_level,
            skills.hourly_rate AS hourly_rate,

            COALESCE(account.spark_token_balance, 0) AS spark_token_balance,
            COALESCE(account.cash_balance, 0) AS cash_balance,

            (SELECT COUNT(*) FROM follows WHERE follows.following_id = users.id) AS total_followers,
            (SELECT COUNT(*) FROM follows WHERE follows.follower_id = users.id) AS total_following
        FROM users
        INNER JOIN skills ON users.id = skills.user_id
        LEFT JOIN account ON users.id = account.user_id
        WHERE users.id = $1
        `,
        [id]
    );
    return result.rows;
}


static async changeAvatar(userId, filepath) {
  const result = await pool.query(
    `UPDATE users 
     SET photourl = COALESCE($1, photourl)
     WHERE id = $2 RETURNING *`,
    [filepath, userId]
  );
  return result.rows[0];
}


static async updateBio(userId, data) {
  const { bio, location, street, zip_code } = data

  const result = await pool.query(
    `UPDATE users 
     SET bio = COALESCE($1, bio),
        location = COALESCE($2, location),
        street = COALESCE($3, street),
        zip_code = COALESCE($4, zip_code)
     WHERE id = $5 RETURNING *`,
    [bio, location, street, zip_code, userId]
  );
  return result.rows[0];
}

}


module.exports = User;
