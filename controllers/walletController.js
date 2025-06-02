const Wallet = require("../models/Wallet");
const User = require("../models/User"); // assuming you have a User model
const { createWalletFundingIntent } = require("../utils/stripe");

// CREATE WALLET
exports.createWalletForUser = async (req, res) => {
  const userId = req.user.id;

  try {
    const existing = await Wallet.findOne({ user: userId });
    if (existing) {
      return res.status(400).json({ message: "Wallet already exists" });
    }

    const newWallet = new Wallet({
      user: userId,
      balance: 0,
      spark_tokens: 20,
      currency: "gbp",
    });

    await newWallet.save();

    res.status(201).json({
      message: "Wallet created with 20 spark tokens.",
      wallet: newWallet,
    });
  } catch (err) {
    res
      .status(500)
      .json({ message: "Error creating wallet", error: err.message });
  }
};

// FUND WALLET
exports.fundWallet = async (req, res) => {
  const userId = req.user.id;
  const { amount } = req.body;

  try {
    const user = await User.findById(userId).select("email");
    const customerEmail = user?.email;

    if (!customerEmail) {
      return res.status(404).json({ message: "User email not found" });
    }

    const clientSecret = await createWalletFundingIntent(
      customerEmail,
      amount, // already in pounds
      "gbp"
    );

    // Update wallet balance and spark_tokens
    await Wallet.findOneAndUpdate(
      { user: userId },
      {
        $inc: { balance: amount, spark_tokens: amount },
        $set: { updated_at: new Date() },
      }
    );

    res.status(200).json({ clientSecret });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      message: "Failed to create wallet funding payment intent",
      error: err.message,
    });
  }
};

// PAY FOR SKILL WITH WALLET
exports.payWithWallet = async (req, res) => {
  const buyerId = req.user.id;
  const { amount, sellerUserId } = req.body;

  try {
    const buyerWallet = await Wallet.findOne({ user: buyerId });
    if (!buyerWallet || buyerWallet.balance < amount) {
      return res.status(400).json({ message: "Insufficient wallet balance" });
    }

    const appFee = Math.floor(amount * 0.04);
    const sellerAmount = amount - appFee;

    // Deduct from buyer and credit seller in a transaction-like manner
    // Note: MongoDB transactions require replica sets; if not available, be careful
    await Wallet.updateOne(
      { user: buyerId },
      { $inc: { balance: -amount }, $set: { updated_at: new Date() } }
    );

    await Wallet.updateOne(
      { user: sellerUserId },
      { $inc: { balance: sellerAmount }, $set: { updated_at: new Date() } }
    );

    // Optionally: Add transaction record here

    res.status(200).json({ message: "Payment successful" });
  } catch (err) {
    res
      .status(500)
      .json({ message: "Failed to complete payment", error: err.message });
  }
};

// CREDIT WALLET AFTER PAYMENT SUCCESS
exports.creditWalletAfterPayment = async (req, res) => {
  const userId = req.user.id;
  const { amount } = req.body;

  try {
    const existing = await Wallet.findOne({ user: userId });

    if (!existing) {
      return res.status(404).json({ message: "Wallet not found" });
    }

    await Wallet.updateOne(
      { user: userId },
      {
        $inc: { balance: amount, spark_tokens: amount },
        $set: { updated_at: new Date() },
      }
    );

    res.status(200).json({ message: "Wallet credited successfully" });
  } catch (err) {
    res
      .status(500)
      .json({ message: "Failed to credit wallet", error: err.message });
  }
};

// GET WALLET BALANCE
exports.getWalletBalance = async (req, res) => {
  const userId = req.user.id;

  try {
    const wallet = await Wallet.findOne({ user: userId }).select(
      "balance spark_tokens currency"
    );

    if (!wallet) {
      return res.status(404).json({ message: "Wallet not found" });
    }

    res.status(200).json(wallet);
  } catch (err) {
    res
      .status(500)
      .json({ message: "Failed to fetch wallet balance", error: err.message });
  }
};
