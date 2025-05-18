const pool = require("../config/db");
const bcrypt = require("bcrypt");

class Skill {
  /* static async create(userId, data) {
        const { skill_type, experience_level, hourly_rate, description } = data;
        const approval_status = 'draft'

        const result = await pool.query(
          'INSERT INTO skills (user_id, skill_type, experience_level, hourly_rate, description, approval_status) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *',
          [userId,skill_type,experience_level,hourly_rate,description, approval_status]
        );

        return result.rows[0];
    } */

  //   static async create(userId, data) {
  //     const {
  //       skill_type,
  //       experience_level,
  //       hourly_rate,
  //       spark_token,
  //       description,
  //       thumbnails,
  //     } = data;
  //     const approval_status = "draft";

  //     const result = await pool.query(
  //       `
  //             INSERT INTO skills (
  //             user_id, skill_type, experience_level, hourly_rate, spark_token, description,
  //             approval_status, thumbnail01, thumbnail02, thumbnail03, thumbnail04
  //             ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
  //             RETURNING *
  //             `,
  //       [
  //         userId,
  //         skill_type,
  //         experience_level,
  //         hourly_rate,
  //         spark_token,
  //         description,
  //         approval_status,
  //         thumbnails.thumbnail01,
  //         thumbnails.thumbnail02,
  //         thumbnails.thumbnail03,
  //         thumbnails.thumbnail04,
  //       ]
  //     );

  //     return result.rows[0];
  //   }
  static async create(userId, data) {
    const {
      skill_type,
      experience_level,
      hourly_rate,
      spark_token,
      description,
      thumbnails,
    } = data;
    const approval_status = "published";

    // Check if the spark_token is already a number, if not, parse it
    const finalSparkToken = spark_token ? parseInt(spark_token, 10) : null;

    console.log("📌 Final spark_token before inserting:", finalSparkToken); // Debug log for final spark_token

    const result = await pool.query(
      `
        INSERT INTO skills (
        user_id, skill_type, experience_level, hourly_rate, spark_token, description, 
        approval_status, thumbnail01, thumbnail02, thumbnail03, thumbnail04
        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) 
        RETURNING *
        `,
      [
        userId,
        skill_type,
        experience_level,
        hourly_rate,
        finalSparkToken, // Use final parsed spark_token here
        description,
        approval_status,
        thumbnails.thumbnail01,
        thumbnails.thumbnail02,
        thumbnails.thumbnail03,
        thumbnails.thumbnail04,
      ]
    );

    return result.rows[0];
  }

  /* static async update(userId, skillId, updates) {
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
    } */

  static async update(userId, skillId, updates) {
    const {
      skill_type,
      experience_level,
      hourly_rate,
      description,
      thumbnails,
    } = updates;

    const result = await pool.query(
      `
            UPDATE skills 
            SET 
            skill_type = COALESCE($1, skill_type),
            experience_level = COALESCE($2, experience_level),
            hourly_rate = COALESCE($3, hourly_rate),
            description = COALESCE($4, description),
            thumbnail01 = COALESCE($5, thumbnail01),
            thumbnail02 = COALESCE($6, thumbnail02),
            thumbnail03 = COALESCE($7, thumbnail03),
            thumbnail04 = COALESCE($8, thumbnail04)
            WHERE id = $9 AND user_id = $10
            RETURNING *
            `,
      [
        skill_type,
        experience_level,
        hourly_rate,
        description,
        thumbnails.thumbnail01,
        thumbnails.thumbnail02,
        thumbnails.thumbnail03,
        thumbnails.thumbnail04,
        skillId,
        userId,
      ]
    );

    return result.rows[0];
  }

  static async updatePublishedStatus(skillId, status) {
    const result = await pool.query(
      `UPDATE skills 
           SET approval_status = COALESCE($1, approval_status)
           WHERE id = $2
           RETURNING *`,
      [status, skillId]
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

  static async retrieveUserSkill(userId) {
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
            WHERE skills.user_id = $1
            `,
      [userId]
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
                users.email AS creator_email,
                users.photourl 
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
                users.email AS creator_email,
                users.photourl 
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
                users.email AS creator_email,
                users.photourl
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.spark_token = $1 
            AND skills.approval_status = 'published'
            `,
      [`%${sparkToken}%`]
    );
    return result.rows;
  }

  static async findSkill(id, userId) {
    const result = await pool.query(
      "SELECT * FROM skills WHERE id = $1 AND user_id = $2",
      [id, userId]
    );
    return result.rows[0];
  }

  static async deletePhoto(column, userId, skillId) {
    const nullVal = null;
    const result = await pool.query(
      `UPDATE skills 
             SET ${column} = ${nullVal}
             WHERE id = $1 AND user_id = $2
             RETURNING *`,
      [skillId, userId]
    );
    return result.rows[0];
  }

  static async searchSkillsByType(skillType) {
    const result = await pool.query(
      `
            SELECT 
                skills.*, 
                users.id AS creator_id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email,
                users.photourl
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.skill_type ILIKE $1 
            AND skills.approval_status = 'published'
            `,
      [`%${skillType}%`]
    );
    return result.rows;
  }

  static async searchUsersBySkillType(skillType) {
    const result = await pool.query(
      `
            SELECT DISTINCT ON (users.id)
                users.id, 
                (users.firstname || ' ' || users.lastname) AS creator_name, 
                users.email AS creator_email,
                users.photourl,
                users.phone,
                skills.skill_type
            FROM skills 
            INNER JOIN users ON skills.user_id = users.id
            WHERE skills.skill_type ILIKE $1 
            AND skills.approval_status = 'published'
            ORDER BY users.id, skills.created_at DESC
            `,
      [`%${skillType}%`]
    );
    return result.rows;
  }
  static async findAll() {
    const result = await pool.query(`SELECT * FROM skills`);
    return result.rows;
  }
  static async findOne(skillId) {
    const result = await pool.query(`SELECT * FROM skills WHERE id = $1`, [
      skillId,
    ]);
    return result.rows[0];
  }

  static async getSkillCategory(status) {
    const result = await pool.query(
      `
            SELECT 
                *
            FROM skills_category
            WHERE status = $1
            `,
      [status]
    );
    return result.rows;
  }
}

module.exports = Skill;
