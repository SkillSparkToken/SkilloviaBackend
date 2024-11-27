const pool = require('../config/db');
const bcrypt = require('bcrypt');

class Skill {
    static async create(userId, data) {
        const { skill_type, experience_level, hourly_rate, description } = data;
        const result = await pool.query(
          'INSERT INTO skills (skill_type,experience_level,hourly_rate,description) VALUES ($1, $2, $3, $4) WHERE user_id = $5  RETURNING *',
          [skill_type,experience_level,hourly_rate,description,userId]
        );
        return result.rows[0];
    }


    static async update(userId, skillId, updates) {
        const { skill_type, experience_level, hourly_rate, description } = updates;
    
        const result = await pool.query(
          `UPDATE skills 
           SET skill_type = COALESCE($1, skill_type),
               experience_level = COALESCE($2, experience_level),
               hourly_rate = COALESCE($3, hourly_rate),
               description = COALESCE($4, description)
           WHERE id = $5 AND user_id = $6
           RETURNING *`,
          [skill_type, experience_level, hourly_rate, description, skillId, userId]
        );
        return result.rows[0];
    }


    static async delete(userId, skillId) {
        const result = await pool.query(
            `DELETE FROM skills 
             WHERE id = $1 AND user_id = $2 
             RETURNING *`,
            [skillId, userId]
        );
    
        return result.rows[0];
    }

}


module.exports = Skill;