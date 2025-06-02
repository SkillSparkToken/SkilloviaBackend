// models/Wallet.js
const mongoose = require("mongoose");

const walletSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      unique: true, // Ensure one wallet per user
    },
    balance: {
      type: Number,
      default: 0,
    },
  },
  { timestamps: true }
);

walletSchema.statics.createWallet = async function (userId) {
  const existingWallet = await this.findOne({ user: userId });
  if (existingWallet) {
    throw new Error("Wallet already exists");
  }
  return await this.create({ user: userId });
};

walletSchema.statics.getWalletByUserId = async function (userId) {
  return await this.findOne({ user: userId });
};

walletSchema.statics.updateBalance = async function (userId, amount) {
  return await this.findOneAndUpdate(
    { user: userId },
    {
      $inc: { balance: amount },
      $set: { updatedAt: new Date() },
    },
    { new: true }
  );
};

walletSchema.statics.deductBalance = async function (userId, amount) {
  const wallet = await this.findOne({ user: userId });
  if (!wallet) throw new Error("Wallet not found");
  if (wallet.balance < amount) throw new Error("Insufficient balance");

  wallet.balance -= amount;
  await wallet.save();
  return wallet;
};

const Wallet = mongoose.model("Wallet", walletSchema);

module.exports = Wallet;
