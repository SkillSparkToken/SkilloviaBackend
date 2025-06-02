const Payment = require('../models/Payment');

exports.addBillingMethod = async (req, res) => {
  const userId = parseInt(req.user.id);

  if(req.body.card_number != null, req.body.expiry_date != null, req.body.cvv != null, req.body.address != null, req.body.city != null){
    try {
        const user = await Payment.findByCardNumber(userId, req.body.card_number);

        if(user == null){
            const docs = await Payment.addBillingMethod(userId, req.body);
            res.status(200).json({ status: 'success', message: 'Billing method added successfully.', data: docs });
        } else {
            res.status(400).send({
                status: 'error',
                message: 'Card already exist',
                data: null
            });
        }
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to add billing method.', data: error });
    }
  } else {
    res.status(400).send({
        status: 'error',
        message: 'Missing parameters',
        data: null
    });
  }
};


exports.retrieveBillingMethods = async (req, res) => {
    const userId = req.user.id;
  
    try {
      const data = await Payment.getUserBillings(userId);

      if(data != null){
        res.status(200).json({ status: 'success', message: 'Billing methods retrieved successfully.', data: data });
      } else {
        res.status(200).json({ status: 'success', message: 'No billing method found', data: null });
      }
      
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to retrieve billing method', data: error });
    }
};


exports.removeBillingCard = async (req, res) => {
    const userId = req.user.id;
    const id = parseInt(req.params.id)   
  
    try {
      const data = await Payment.deleteBillingMethod(userId, id);
      res.status(200).json({ status: 'success', message: 'Billing method removed successfully.', data: data });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to remove billing method.', data: error });
    }
};


// Withdrawal Methods

exports.addWithdrawMethod = async (req, res) => {
    const userId = req.user.id;
  
    if(req.body.bank_name != null, req.body.account_number != null, req.body.account_name != null){
      try {
          const user = await Payment.findByAccNumber(req.body.account_number);
  
          if(user == null){
              const docs = await Payment.addWithdrawMethod(userId, req.body);
              res.status(200).json({ status: 'success', message: 'Withdrawal method added successfully.', data: docs });
          } else {
              res.status(400).send({
                  status: 'error',
                  message: 'Account number already exist',
                  data: null
              });
          }
      } catch (error) {
          res.status(500).json({status: 'error', message: 'Failed to add Withdrawal method', data: error });
      }
    } else {
      res.status(400).send({
          status: 'error',
          message: 'Missing parameters',
          data: null
      });
    }
};
  
  
exports.retrieveWithdrawalMethods = async (req, res) => {
    const userId = req.user.id;

    try {
    const data = await Payment.getUserWithdrawalMethods(userId);

    if(data != null){
        res.status(200).json({ status: 'success', message: 'Withdrawal methods retrieved successfully.', data: data });
    } else {
        res.status(200).json({ status: 'success', message: 'No Withdrawal method found', data: null });
    }
    
    } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve Withdrawal method', data: error });
    }
};
  
  
exports.removeWithdrawalAccount = async (req, res) => {
    const userId = req.user.id;
    const id = parseInt(req.params.id)   

    try {
    const data = await Payment.deleteWithdrawalMethod(userId, id);
    res.status(200).json({ status: 'success', message: 'Withdrawal method removed successfully.', data: data });
    } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to remove withdrawal method.', data: error });
    }
};