const mongoose = require("mongoose");

const billingMethodSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    card_number: {
      type: String,
      required: true,
    },
    expiry_date: {
      type: String,
      required: true,
    },
    cvv: {
      type: String,
      required: true,
    },
    address: String,
    city: String,
    postal_code: String,
  },
  { timestamps: true }
);

const withdrawalMethodSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    bank_name: {
      type: String,
      required: true,
    },
    account_number: {
      type: String,
      required: true,
    },
    account_name: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

const BillingMethod = mongoose.model("BillingMethod", billingMethodSchema);
const WithdrawalMethod = mongoose.model(
  "WithdrawalMethod",
  withdrawalMethodSchema
);

// Adding statics to BillingMethod
billingMethodSchema.statics.addBillingMethod = async function (userId, data) {
  const billingMethod = new this({ userId, ...data });
  return await billingMethod.save();
};

billingMethodSchema.statics.getUserBillings = async function (userId) {
  return await this.find({ userId }).exec();
};

billingMethodSchema.statics.deleteBillingMethod = async function (userId, id) {
  return await this.findOneAndDelete({ _id: id, userId }).exec();
};

billingMethodSchema.statics.findByCardNumber = async function (
  userId,
  cardNumber
) {
  return await this.findOne({ userId, card_number: cardNumber }).exec();
};

// Adding statics to WithdrawalMethod
withdrawalMethodSchema.statics.addWithdrawMethod = async function (
  userId,
  data
) {
  const withdrawMethod = new this({ userId, ...data });
  return await withdrawMethod.save();
};

withdrawalMethodSchema.statics.getUserWithdrawalMethods = async function (
  userId
) {
  return await this.find({ userId }).exec();
};

withdrawalMethodSchema.statics.deleteWithdrawalMethod = async function (
  userId,
  id
) {
  return await this.findOneAndDelete({ _id: id, userId }).exec();
};

withdrawalMethodSchema.statics.findByAccNumber = async function (
  userId,
  accNumber
) {
  return await this.findOne({ userId, account_number: accNumber }).exec();
};

module.exports = {
  BillingMethod,
  WithdrawalMethod,
};
