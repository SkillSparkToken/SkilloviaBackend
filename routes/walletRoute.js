// routes/walletRoutes.js
const express = require("express");
const router = express.Router();
const {
  createWalletForUser,
  fundWallet,
  payWithWallet,
  getWalletBalance,
  creditWalletAfterPayment,
} = require("../controllers/walletController");
const verify = require("../middlewares/verifyToken");

// Create wallet for user
router.post("/wallet/create", verify, createWalletForUser);

// Fund wallet (create Stripe intent)
router.post("/wallet/fund", verify, fundWallet);

// Pay for skill with wallet
router.post("/wallet/pay", verify, payWithWallet);
router.post("/wallet/credit", verify, creditWalletAfterPayment);

// Get user's wallet balance
router.get("/wallet/balance", verify, getWalletBalance);

module.exports = router;
