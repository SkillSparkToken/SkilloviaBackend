const { stat } = require('fs/promises');
const pool = require('../config/db');
const bcrypt = require('bcrypt');

class User {
  static async create(data) {
    const {phone, email, firstname, lastname, gender, password } = data;
    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      'INSERT INTO users (phone, email, firstname, lastname, gender, password, is_email_verified) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *',
      [phone, email, firstname, lastname, gender, hashedPassword, 1]
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


  static async checkUserExist(phone, email) {
    const result = await pool.query(
      'SELECT * FROM users WHERE phone = $1 OR email = $2',
      [phone, email]
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

          JSON_AGG(
              JSON_BUILD_OBJECT(
                  'description', skills.description,
                  'skill_type', skills.skill_type,
                  'experience_level', skills.experience_level,
                  'hourly_rate', skills.hourly_rate
              )
          ) FILTER (WHERE skills.id IS NOT NULL) AS skills,

          COALESCE(account.spark_token_balance, 0) AS spark_token_balance,
          COALESCE(account.cash_balance, 0) AS cash_balance,

          (SELECT COUNT(*) FROM follows WHERE follows.following_id = users.id) AS total_followers,
          (SELECT COUNT(*) FROM follows WHERE follows.follower_id = users.id) AS total_following
      FROM users
      LEFT JOIN skills ON users.id = skills.user_id
      LEFT JOIN account ON users.id = account.user_id
      WHERE users.id = $1
      GROUP BY 
        users.id, 
        account.spark_token_balance, 
        account.cash_balance;
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


static async verifyEmail(email, code) {
  const result = await pool.query(
    'SELECT * FROM verifyemail WHERE email = $1 AND token = $2',
    [email, code]
  );
  return result.rows[0];
}


static async insertVerificationCode(email, code) {
  const result = await pool.query(
  'INSERT INTO verifyemail (email, token) VALUES ($1,$2) RETURNING *',
  [email, code]
  );
  return result.rows[0];
}


static async updateVerificationCode(email, code) {
  const result = await pool.query(
    `UPDATE verifyemail 
     SET token = $1
     WHERE email = $2 RETURNING *`,
    [code, email]
  );
  return result.rows[0];
}


static async updateVerificationStatus(email, status) {
  const result = await pool.query(
    `UPDATE users 
     SET is_email_verified = $1
     WHERE email = $2 RETURNING *`,
    [status, email]
  );
  return result.rows[0];
}


static async checkVerificationExist(email) {
  const result = await pool.query(
    'SELECT * FROM verifyemail WHERE email = $1',
    [email]
  );
  return result.rows[0];
}


static async deleteUser(email) {
  const result = await pool.query(
      `DELETE FROM users 
       WHERE email = $1 
       RETURNING *`,
      [email]
  );

  return result.rows[0];
}


static async updateCordinates(lat, lng, radius, date, userId) {
  const result = await pool.query(
    `UPDATE users 
     SET lat = COALESCE($1, lat),
     lon = COALESCE($2, lon),
     radius = COALESCE($3, radius),
     location_updated_at = COALESCE($4, location_updated_at)
     WHERE id = $5 RETURNING *`,
    [lat, lng, radius, date, userId]
  );
  return result.rows[0];
}


static async findNearbyUsers(lat, lon, radius = 5) {
  
  const result = await pool.query(
  `SELECT id, firstname, lastname, lat, lon, email, phone, gender, photourl,
      (
        6371 * acos(
          cos(radians($1)) * cos(radians(lat)) *
          cos(radians(lon) - radians($2)) +
          sin(radians($1)) * sin(radians(lat))
        )
      ) AS distance
    FROM users
    WHERE (
      6371 * acos(
        cos(radians($1)) * cos(radians(lat)) *
        cos(radians(lon) - radians($2)) +
        sin(radians($1)) * sin(radians(lat))
      )
    ) <= $3
    ORDER BY distance;`,
    [lat, lon, radius]
  );
  
  return result.rows
}


}


module.exports = User;
