// utils/createWalletUtil.js
const pool = require("../config/db");
const createWalletForUser = async (userId) => {
  const existing = await pool.query("SELECT * FROM wallet WHERE user_id = $1", [
    userId,
  ]);
  if (existing.rows.length > 0) {
    return { message: "Wallet already exists", wallet: existing.rows[0] };
  }

  const result = await pool.query(
    "INSERT INTO wallet (user_id, balance, currency) VALUES ($1, $2, $3) RETURNING *",
    [userId, 0, "gbp"]
  );

  return { message: "Wallet created", wallet: result.rows[0] };
};

module.exports = createWalletForUser;
