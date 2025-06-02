// utils/createWalletUtil.js
const Wallet = require("../models/Wallet");

const createWalletForUser = async (userId) => {
  // Check if wallet exists
  const existing = await Wallet.findOne({ user: userId });

  if (existing) {
    return { message: "Wallet already exists", wallet: existing };
  }

  // Create new wallet
  const wallet = new Wallet({
    user: userId,
    balance: 0,
    currency: "gbp",
  });

  await wallet.save();

  return { message: "Wallet created", wallet };
};

module.exports = createWalletForUser;
