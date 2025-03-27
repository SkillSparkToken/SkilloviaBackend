const pool = require('../config/db');
const bcrypt = require('bcrypt');

class SuggestSkill {
    static async create(userId, data) {
        const { name } = data;
        const result = await pool.query(
          'INSERT INTO suggest_skills (user_id, name) VALUES ($1, $2) RETURNING *',
          [userId, name]
        );
        return result.rows[0];
    }


    static async updateStatus(id, updates) {
        const { status } = updates;
    
        const result = await pool.query(
          `UPDATE suggest_skills 
           SET approval_status = COALESCE($1, approval_status)
           WHERE id = $2
           RETURNING *`,
          [status, id]
        );
        return result.rows[0];
    }


    static async delete(id) {
        const result = await pool.query(
            `DELETE FROM suggest_skills 
             WHERE id = $1
             RETURNING *`,
            [id]
        );
    
        return result.rows[0];
    }


    static async findSuggestedSkill(data) {
        const { name } = data;

        const result = await pool.query(
          'SELECT * FROM suggest_skills WHERE name = $1',
          [name]
        );
        return result.rows[0];
      }


    static async retrieveSuggestedSkills(status) {
        const result = await pool.query(
            `
            SELECT 
                suggest_skills.*, 
                users.id AS creator_id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email 
            FROM suggest_skills 
            INNER JOIN users ON suggest_skills.user_id = users.id
            WHERE suggest_skills.approval_status = $1
            `,
            [status]
        );
        return result.rows;
    }
    

}


module.exports = SuggestSkill;