const pool = require('../config/db');
const bcrypt = require('bcrypt');

class Kyc {
    static async upload(userId, method, type, file) {

        const result = await pool.query(
        'INSERT INTO kyc (user_id, kyc_method, kyc_id_type, document_url) VALUES ($1,$2,$3,$4) RETURNING *',
        [userId, method, type, file]
        );
        return result.rows[0];
    }


    static async reupload(id, updates) {
        const { kyc_method, kyc_id_type, document_url} = updates;

        const result = await pool.query(
        `UPDATE kyc 
        SET kyc_method = COALESCE($1, kyc_method),
            kyc_id_type = COALESCE($2, kyc_id_type),
            document_url = COALESCE($3, document_url)
        WHERE id = $4 RETURNING *`,
        [kyc_method, kyc_id_type, document_url, id]
        );
        return result.rows[0];
    }


    static async changeStatus(id, status) {

        const result = await pool.query(
        `UPDATE kyc 
        SET approval_status = COALESCE($1, approval_status)
        WHERE id = $2 RETURNING *`,
        [status, id]
        );
        return result.rows[0];
    }


    static async getKycByUserId(id) {
        const result = await pool.query(
            `
            SELECT 
                *
            FROM kyc
            WHERE user_id = $1
            `,
            [id]
        );
        return result.rows;
    }


    static async getKycs(method, status) {
        const result = await pool.query(
            `
            SELECT 
                kyc.*,
                users.id AS user_id,
                users.firstname AS firstname,
                users.lastname AS lastname,
                users.email,
                users.phone,
                users.gender 
            FROM kyc
            INNER JOIN users ON users.id = kyc.user_id
            WHERE kyc.kyc_method = $1 AND kyc.approval_status = $2
            `,
            [method, status]
        );
        return result.rows;
    }


    static async getUserKyc(id, method) {
        const result = await pool.query(
            `
            SELECT *
            FROM kyc
            WHERE user_id = $1 AND kyc_method = $2
            `,
            [id, method]
        );
        return result.rows;
    }


    static async deleteKyc(userId, id, method) {
        const result = await pool.query(
            `DELETE FROM kyc 
             WHERE id = $1 AND user_id = $2 AND kyc_method = $3
             RETURNING *`,
            [id, userId, method]
        );
    
        return result.rows[0];
    }

}


module.exports = Kyc;
