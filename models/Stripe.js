const mongoose = require("mongoose");

const stripeAccountSchema = new mongoose.Schema(
  {
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    stripe_account_id: {
      type: String,
      required: true,
    },
    charges_enabled: {
      type: Boolean,
      default: false,
    },
    payouts_enabled: {
      type: Boolean,
      default: false,
    },
    details_submitted: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true, // Automatically manages createdAt and updatedAt
  }
);

// Static methods
stripeAccountSchema.statics.createStripeAccount = async function (
  user_id,
  stripe_account_id
) {
  const stripeAccount = new this({ user_id, stripe_account_id });
  return await stripeAccount.save();
};

stripeAccountSchema.statics.findByUserId = async function (user_id) {
  return await this.findOne({ user_id });
};

stripeAccountSchema.statics.updateStripeAccountStatus = async function (
  stripe_account_id,
  updates
) {
  return await this.findOneAndUpdate(
    { stripe_account_id },
    {
      $set: {
        charges_enabled: updates.charges_enabled ?? false,
        payouts_enabled: updates.payouts_enabled ?? false,
        details_submitted: updates.details_submitted ?? false,
      },
    },
    { new: true }
  );
};

stripeAccountSchema.statics.deleteById = async function (_id) {
  return await this.findByIdAndDelete(_id);
};

module.exports = mongoose.model("StripeAccount", stripeAccountSchema);
