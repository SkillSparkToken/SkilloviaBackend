const pool = require('../config/db');
const bcrypt = require('bcrypt');

class Skill {
    static async create(userId, data) {
        const { skill_type, experience_level, hourly_rate, description } = data;
        const approval_status = 'draft'

        const result = await pool.query(
          'INSERT INTO skills (user_id, skill_type, experience_level, hourly_rate, description, approval_status) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *',
          [userId,skill_type,experience_level,hourly_rate,description, approval_status]
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


    static async updatePublishedStatus(userId, skillId, status) {
    
        const result = await pool.query(
          `UPDATE skills 
           SET approval_status = COALESCE($1, approval_status)
           WHERE id = $2 AND user_id = $3
           RETURNING *`,
          [status, skillId, userId]
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


    static async retrievePublishedSkill(status) {
        const result = await pool.query(
            `
            SELECT 
                skills.*, 
                users.id AS user_id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email 
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.approval_status = $1
            `,
            [status]
        );
        return result.rows;
    }
    

    static async searchSkillsByName(skillName) {
        const result = await pool.query(
            `
            SELECT 
                skills.*, 
                users.id AS creator_id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email 
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.skill_type ILIKE $1 
            AND skills.approval_status = 'published'
            `,
            [`%${skillName}%`]
        );
        return result.rows;
    }

    
    static async searchSkillsByCreatorName(creatorName) {
        const result = await pool.query(
            `
            SELECT 
                skills.*, 
                users.id AS creator_id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email 
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE (users.firstname || ' ' || users.lastname) ILIKE $1 
            AND skills.approval_status = 'published'
            `,
            [`%${creatorName}%`]
        );
        return result.rows;
    }


    static async searchSkillsBySparktoken(sparkToken) {
        const result = await pool.query(
            `
            SELECT 
                skills.*, 
                users.id AS creator_id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email 
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.spark_token = $1 
            AND skills.approval_status = 'published'
            `,
            [`%${sparkToken}%`]
        );
        return result.rows;
    }
    

}


module.exports = Skill;