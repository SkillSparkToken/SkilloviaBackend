const pool = require("../config/db");

class Wallet {
  static async createWallet(userId) {
    const existing = await pool.query(
      "SELECT * FROM wallet WHERE user_id = $1",
      [userId]
    );
    if (existing.rows.length > 0) {
      throw new Error("Wallet already exists");
    }

    const result = await pool.query(
      `INSERT INTO wallet (user_id) VALUES ($1) RETURNING *`,
      [userId]
    );
    return result.rows[0];
  }

  static async getWalletByUserId(userId) {
    const result = await pool.query("SELECT * FROM wallet WHERE user_id = $1", [
      userId,
    ]);
    return result.rows[0];
  }

  static async updateBalance(userId, amount) {
    const result = await pool.query(
      `UPDATE wallet 
       SET balance = balance + $1, updated_at = CURRENT_TIMESTAMP 
       WHERE user_id = $2 RETURNING *`,
      [amount, userId]
    );
    return result.rows[0];
  }

  static async deductBalance(userId, amount) {
    const result = await pool.query(
      `UPDATE wallet 
       SET balance = balance - $1, updated_at = CURRENT_TIMESTAMP 
       WHERE user_id = $2 AND balance >= $1 RETURNING *`,
      [amount, userId]
    );
    return result.rows[0];
  }
}

module.exports = Wallet;
