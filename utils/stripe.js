const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

const createConnectedAccount = async (email) => {
  try {
    const account = await stripe.accounts.create({
      country: 'GB',
      email: email,
      business_type: 'individual',
      capabilities: {
        transfers: { requested: true }, // Enable payouts
      },
      controller: {
        fees: {
          payer: 'application',
        },
        losses: {
          payments: 'application',
        },
        stripe_dashboard: {
          type: 'express',
        },
      },
    });

    console.log("Connected Account Created:", account.id);
    return account;
  } catch (error) {
    console.error("Error creating connected account:", error);
    //return false
    throw error
  }
};


const generateAccountLink = async (account) => {
  try {
    const accountLink = await stripe.accountLinks.create({
      account: account,
      return_url: `https://skilloviaweb.vercel.app/success-pay/${account}`,
      refresh_url: `https://skilloviaweb.vercel.app/failure-pay/${account}`,
      type: "account_onboarding",
    });

    return accountLink;
  } catch (error) {
    console.error(
      "An error occurred when calling the Stripe API to create an account link:",
      error
    );
    throw error.message
  }
}


const processSplitPayment = async (customerEmail, amount, currency, connectedAccountId) => {
  try {
    // Calculate platform fee (4% of the total amount)
    const platformFee = Math.floor(amount * 0.04 * 100); // Convert to cents
    const totalAmount = (amount * 100) + platformFee

    // Create a Payment Intent with destination charge and application fee
    const paymentIntent = await stripe.paymentIntents.create({
      amount: totalAmount,
      currency: currency,
      payment_method_types: ['card'],
      receipt_email: customerEmail,
      application_fee_amount: platformFee,
      transfer_data: {
        destination: connectedAccountId, // The vendor's Stripe account ID
      },
    });

    console.log('Payment Intent Created:', paymentIntent.id);
    return paymentIntent.client_secret;
  } catch (error) {
    console.error('Error processing split payment:', error);
    throw error;
  }
};



module.exports = { 
  createConnectedAccount,
  generateAccountLink,
  processSplitPayment,
};
