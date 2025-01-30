const pool = require('../config/db');
const bcrypt = require('bcrypt');

class Admin {

    /* ---------------   SKILLS  ------------------- */
    /* ---------------  DATA  ---------------------- */

    static async publishSkill(skillId, status) {
        const result = await pool.query(
          `UPDATE skills 
           SET approval_status = COALESCE($1, approval_status)
           WHERE id = $2
           RETURNING *`,
          [status, skillId]
        );
        return result.rows[0];
    }


    static async unPublishSkill(skillId, status) {
        const result = await pool.query(
          `UPDATE skills 
           SET approval_status = COALESCE($1, approval_status)
           WHERE id = $2
           RETURNING *`,
          [status, skillId]
        );
        return result.rows[0];
    }


    static async deleteSkill(skillId) {
        const result = await pool.query(
            `DELETE FROM skills 
             WHERE id = $1
             RETURNING *`,
            [skillId]
        );
    
        return result.rows[0];
    }


    static async retrieveSkillByStatus(status) {
        const result = await pool.query(
            `
            SELECT 
                skills.*, 
                users.id AS user_id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email,
                users.photourl 
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.approval_status = $1
            `,
            [status]
        );
        return result.rows;
    }


    static async retrieveUserSkills(userId) {
        const result = await pool.query(
            `
            SELECT 
                skills.*,
                (users.firstname || ' ' || users.lastname) AS creator_name
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.user_id = $1
            `,
            [userId]
        );
        return result.rows;
    }


    static async findSkill(id) {
        const result = await pool.query(
          'SELECT * FROM skills WHERE id = $1',
          [id]
        );
        return result.rows[0];
    }
    

    /* ---------------   USER  ------------------- */
    /* ---------------  DATA  --------------------- */


    static async createUser(data) {
        const {phone, email, firstname, lastname, gender, password } = data;
        const hashedPassword = await bcrypt.hash(password, 10);
    
        const result = await pool.query(
          'INSERT INTO users (phone, email, firstname, lastname, gender, password, is_email_verified) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *',
          [phone, email, firstname, lastname, gender, hashedPassword, 1]
        );
        return result.rows[0];
    }


    static async checkUserExist(phone, email) {
        const result = await pool.query(
          'SELECT * FROM users WHERE phone = $1 OR email = $2',
          [phone, email]
        );
        return result.rows[0];
    }


    static async updateUser(userId, updates) {
        const { email, firstname, lastname, gender, password } = updates;
        const hashedPassword = password ? await bcrypt.hash(password, 10) : null;
    
        const result = await pool.query(
          `UPDATE users 
           SET email = COALESCE($1, email),
               firstname = COALESCE($2, firstname),
               lastname = COALESCE($3, lastname),
               gender = COALESCE($4, gender),
               password = COALESCE($5, password)
           WHERE id = $6 RETURNING *`,
          [email, firstname, lastname, gender, hashedPassword, userId]
        );
        return result.rows[0];
    }


    static async getAllusers() {
        const result = await pool.query(
          'SELECT * FROM users'
        );
        return result.rows;
    }


    static async changeUserRole(id, roleId) {
        const result = await pool.query(
        `UPDATE users
        SET role_id = COALESCE($1, role_id)
        WHERE id = $2 RETURNING *`,
        [roleId, id]
        );
        return result.rows[0];
    }


    /* ---------------   KYC  ------------------- */
    /* ---------------  DATA  --------------------- */


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


    static async getKycs(status) {
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
            WHERE kyc.approval_status = $1
            `,
            [status]
        );
        return result.rows;
    }


    static async deleteKyc(id) {
        const result = await pool.query(
            `DELETE FROM kyc 
             WHERE id = $1
             RETURNING *`,
            [id]
        );
        return result.rows[0];
    }

}


module.exports = Admin;