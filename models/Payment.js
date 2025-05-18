const pool = require('../config/db');
const bcrypt = require('bcrypt');

class Payment {
    static async addBillingMethod(userId, data) {
        const { card_number, expiry_date, cvv, address, city, postal_code } = data;

        const result = await pool.query(
        'INSERT INTO billing_methods (user_id, card_number, expiry_date, cvv, address, city, postal_code) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *',
        [userId, card_number, expiry_date, cvv, address, city, postal_code]
        );
        return result.rows[0];
    }


    static async getUserBillings(id) {
        const result = await pool.query(
            `
            SELECT *
            FROM billing_methods
            WHERE user_id = $1
            `,
            [id]
        );
        return result.rows;
    }


    static async deleteBillingMethod(userId, id) {
        const result = await pool.query(
            `DELETE FROM billing_methods 
             WHERE id = $1 AND user_id = $2 
             RETURNING *`,
            [id, userId]
        );
    
        return result.rows[0];
    }


    static async findByCardNumber(userId, cardNumber) {
        const result = await pool.query(
          'SELECT * FROM billing_methods WHERE user_id = $1 AND card_number = $2',
          [userId,cardNumber]
        );
        return result.rows[0];
    }


    // Add Withdrawal Methods

    static async addWithdrawMethod(userId, data) {
        const { bank_name, account_number, account_name } = data;

        const result = await pool.query(
        'INSERT INTO withdrawal_methods (user_id, bank_name, account_number, account_name) VALUES ($1,$2,$3,$4) RETURNING *',
        [userId, bank_name, account_number, account_name]
        );
        return result.rows[0];
    }


    static async getUserWithdrawalMethods(id) {
        const result = await pool.query(
            `
            SELECT *
            FROM withdrawal_methods
            WHERE user_id = $1
            `,
            [id]
        );
        return result.rows;
    }


    static async deleteWithdrawalMethod(userId, id) {
        const result = await pool.query(
            `DELETE FROM withdrawal_methods 
             WHERE id = $1 AND user_id = $2 
             RETURNING *`,
            [id, userId]
        );
    
        return result.rows[0];
    }


    static async findByAccNumber(userId, accNumber) {
        const result = await pool.query(
          'SELECT * FROM withdrawal_methods WHERE user_id = $1 AND account_number = $2',
          [userId,accNumber]
        );
        return result.rows[0];
    }

}


module.exports = Payment;
