// const pool = require('../config/db');
// const bcrypt = require('bcrypt');

// class Admin {

//     /* ---------------   SKILLS  ------------------- */
//     /* ---------------  DATA  ---------------------- */

//     static async publishSkill(skillId, status) {
//         const result = await pool.query(
//           `UPDATE skills
//            SET approval_status = COALESCE($1, approval_status)
//            WHERE id = $2
//            RETURNING *`,
//           [status, skillId]
//         );
//         return result.rows[0];
//     }

//     static async unPublishSkill(skillId, status) {
//         const result = await pool.query(
//           `UPDATE skills
//            SET approval_status = COALESCE($1, approval_status)
//            WHERE id = $2
//            RETURNING *`,
//           [status, skillId]
//         );
//         return result.rows[0];
//     }

//     static async deleteSkill(skillId) {
//         const result = await pool.query(
//             `DELETE FROM skills
//              WHERE id = $1
//              RETURNING *`,
//             [skillId]
//         );

//         return result.rows[0];
//     }

//     static async retrieveSkillByStatus(status) {
//         const result = await pool.query(
//             `
//             SELECT
//                 skills.*,
//                 users.id AS user_id,
//                 (users.firstname || ' ' || users.lastname) AS creator_name,
//                 users.email AS creator_email,
//                 users.photourl
//             FROM skills
//             INNER JOIN users ON skills.user_id = users.id
//             WHERE skills.approval_status = $1
//             `,
//             [status]
//         );
//         return result.rows;
//     }

//     static async retrieveUserSkills(userId) {
//         const result = await pool.query(
//             `
//             SELECT
//                 skills.*,
//                 (users.firstname || ' ' || users.lastname) AS creator_name
//             FROM skills
//             INNER JOIN users ON skills.user_id = users.id
//             WHERE skills.user_id = $1
//             `,
//             [userId]
//         );
//         return result.rows;
//     }

//     static async findSkill(id) {
//         const result = await pool.query(
//           'SELECT * FROM skills WHERE id = $1',
//           [id]
//         );
//         return result.rows[0];
//     }

//     /* ---------------   USER  ------------------- */
//     /* ---------------  DATA  --------------------- */

//     static async createUser(data) {
//         const {phone, email, firstname, lastname, gender, password } = data;
//         const hashedPassword = await bcrypt.hash(password, 10);

//         const result = await pool.query(
//           'INSERT INTO users (phone, email, firstname, lastname, gender, password, is_email_verified) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *',
//           [phone, email, firstname, lastname, gender, hashedPassword, 1]
//         );
//         return result.rows[0];
//     }

//     static async checkUserExist(phone, email) {
//         const result = await pool.query(
//           'SELECT * FROM users WHERE phone = $1 OR email = $2',
//           [phone, email]
//         );
//         return result.rows[0];
//     }

//     static async updateUser(userId, updates) {
//         const { email, firstname, lastname, gender, password } = updates;
//         const hashedPassword = password ? await bcrypt.hash(password, 10) : null;

//         const result = await pool.query(
//           `UPDATE users
//            SET email = COALESCE($1, email),
//                firstname = COALESCE($2, firstname),
//                lastname = COALESCE($3, lastname),
//                gender = COALESCE($4, gender),
//                password = COALESCE($5, password)
//            WHERE id = $6 RETURNING *`,
//           [email, firstname, lastname, gender, hashedPassword, userId]
//         );
//         return result.rows[0];
//     }

//     static async getAllusers() {
//         const result = await pool.query(
//           'SELECT * FROM users'
//         );
//         return result.rows;
//     }

//     /* static async getProfileByUserId(id) {
//         const result = await pool.query(
//             `
//             SELECT
//                 users.*,

//                 COALESCE(
//                     JSON_AGG(
//                         JSON_BUILD_OBJECT(
//                             'description', skills.description,
//                             'skill_type', skills.skill_type,
//                             'experience_level', skills.experience_level,
//                             'hourly_rate', skills.hourly_rate,
//                             'thumbnail01', skills.thumbnail01,
//                             'thumbnail02', skills.thumbnail02,
//                             'thumbnail03', skills.thumbnail03,
//                             'thumbnail04', skills.thumbnail04
//                         )
//                     ) FILTER (WHERE skills.id IS NOT NULL),
//                     '[]'
//                 ) AS skills,

//                 COALESCE(account.spark_token_balance, 0) AS spark_token_balance,
//                 COALESCE(account.cash_balance, 0) AS cash_balance,

//                 (SELECT COUNT(*) FROM follows WHERE follows.following_id = users.id) AS total_followers,
//                 (SELECT COUNT(*) FROM follows WHERE follows.follower_id = users.id) AS total_following

//             FROM users
//             LEFT JOIN skills ON users.id = skills.user_id
//             LEFT JOIN account ON users.id = account.user_id
//             WHERE users.id = $1

//             GROUP BY users.id, account.spark_token_balance, account.cash_balance;
//             `,
//             [id]
//         );
//         return result.rows;
//     } */

//     static async getProfileByUserId(id) {
//         const result = await pool.query(
//             `
//             SELECT
//                 users.*,

//                 COALESCE(
//                     JSON_AGG(
//                         JSON_BUILD_OBJECT(
//                             'description', skills.description,
//                             'skill_type', skills.skill_type,
//                             'experience_level', skills.experience_level,
//                             'hourly_rate', skills.hourly_rate,
//                             'thumbnail01', skills.thumbnail01,
//                             'thumbnail02', skills.thumbnail02,
//                             'thumbnail03', skills.thumbnail03,
//                             'thumbnail04', skills.thumbnail04
//                         )
//                     ) FILTER (WHERE skills.id IS NOT NULL),
//                     '[]'
//                 ) AS skills,

//                 COALESCE(
//                     JSON_AGG(
//                         JSON_BUILD_OBJECT(
//                             'kyc_method', kyc.kyc_method,
//                             'kyc_id_type', kyc.kyc_id_type,
//                             'document_url', kyc.document_url,
//                             'approval_status', kyc.approval_status,
//                             'uploaded_date', kyc.updated_at
//                         )
//                     ) FILTER (WHERE kyc.id IS NOT NULL),
//                     '[]'
//                 ) AS kyc,

//                 COALESCE(account.spark_token_balance, 0) AS spark_token_balance,
//                 COALESCE(account.cash_balance, 0) AS cash_balance,

//                 (SELECT COUNT(*) FROM follows WHERE follows.following_id = users.id) AS total_followers,
//                 (SELECT COUNT(*) FROM follows WHERE follows.follower_id = users.id) AS total_following

//             FROM users
//             LEFT JOIN skills ON users.id = skills.user_id
//             LEFT JOIN account ON users.id = account.user_id
//             LEFT JOIN kyc ON users.id = kyc.user_id  -- Added KYC join

//             WHERE users.id = $1

//             GROUP BY users.id, account.spark_token_balance, account.cash_balance;
//             `,
//             [id]
//         );
//         return result.rows;
//     }

//     static async changeUserRole(id, roleId) {
//         const result = await pool.query(
//         `UPDATE users
//         SET role_id = COALESCE($1, role_id)
//         WHERE id = $2 RETURNING *`,
//         [roleId, id]
//         );
//         return result.rows[0];
//     }

//     /* ---------------   KYC  ------------------- */
//     /* ---------------  DATA  --------------------- */

//     static async changeStatus(id, status) {
//         const result = await pool.query(
//         `UPDATE kyc
//         SET approval_status = COALESCE($1, approval_status)
//         WHERE id = $2 RETURNING *`,
//         [status, id]
//         );
//         return result.rows[0];
//     }

//     static async getKycByUserId(id) {
//         const result = await pool.query(
//             `
//             SELECT
//                 *
//             FROM kyc
//             WHERE user_id = $1
//             `,
//             [id]
//         );
//         return result.rows;
//     }

//     static async getKycs(status) {
//         const result = await pool.query(
//             `
//             SELECT
//                 kyc.*,
//                 users.id AS user_id,
//                 users.firstname AS firstname,
//                 users.lastname AS lastname,
//                 users.email,
//                 users.phone,
//                 users.gender
//             FROM kyc
//             INNER JOIN users ON users.id = kyc.user_id
//             WHERE kyc.approval_status = $1
//             `,
//             [status]
//         );
//         return result.rows;
//     }

//     static async deleteKyc(id) {
//         const result = await pool.query(
//             `DELETE FROM kyc
//              WHERE id = $1
//              RETURNING *`,
//             [id]
//         );
//         return result.rows[0];
//     }

//     static async addSkillCategory(data, thumbnail) {
//         const { title, description } = data;
//         const status = 'published';

//         const result = await pool.query(
//             `
//             INSERT INTO skills_category (
//             title, description, thumbnail, status
//             ) VALUES ($1, $2, $3, $4)
//             RETURNING *
//             `,
//             [title, description, thumbnail, status ]
//         );

//         return result.rows[0];
//     }

//     static async getSkillCategory(status) {
//         const result = await pool.query(
//             `
//             SELECT
//                 *
//             FROM skills_category
//             WHERE status = $1
//             `,
//             [status]
//         );
//         return result.rows;
//     }

// }

// module.exports = Admin;const bcrypt = require("bcrypt");
const Skill = require("../models/Skill");
const User = require("../models/User");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt"); // or 'bcryptjs' if you use that package

class Admin {
  /** ----------- SKILLS ------------ */

  static async publishSkill(skillId, status) {
    return await Skill.findByIdAndUpdate(
      skillId,
      { approval_status: status },
      { new: true }
    );
  }

  static async unPublishSkill(skillId, status) {
    return await Skill.findByIdAndUpdate(
      skillId,
      { approval_status: status },
      { new: true }
    );
  }

  static async deleteSkill(skillId) {
    return await Skill.findByIdAndDelete(skillId);
  }

  static async retrieveSkillByStatus(status) {
    return await Skill.find({ approval_status: status })
      .populate("user_id", "firstname lastname email photourl")
      .lean();
  }

  static async retrieveUserSkills(userId) {
    return await Skill.find({ user_id: userId })
      .populate("user_id", "firstname lastname")
      .lean();
  }

  static async findSkill(id) {
    return await Skill.findById(id);
  }

  /** ----------- USERS ------------ */

  static async createUser(data) {
    const { phone, email, firstname, lastname, gender, password } = data;
    const hashedPassword = await bcrypt.hash(password, 10);
    const code = Math.floor(1000 + Math.random() * 900000);
    const referralCode = firstname + code;

    const newUser = new User({
      phone,
      email,
      firstname,
      lastname,
      gender,
      password: hashedPassword,
      is_email_verified: true,
      referral_code: referralCode,
    });

    return await newUser.save();
  }

  static async createAnyUser(data, options = {}) {
    const { phone, email, firstname, lastname, gender, password } = data;
    const { role_id } = options;

    const hashedPassword = await bcrypt.hash(password, 10);
    const code = Math.floor(1000 + Math.random() * 900000);
    const referralCode = firstname + code;

    const newUser = new User({
      phone,
      email,
      firstname,
      lastname,
      gender,
      password: hashedPassword,
      is_email_verified: true,
      referral_code: referralCode,
      role_id: role_id || 2, // Default to normal user role_id = 2 if not provided
    });

    return await newUser.save();
  }

  //   static async addSkillCategory(data, thumbnail) {
  //     const { title, description } = data;
  //     const status = "published";

  //     const result = await pool.query(
  //       `
  //             INSERT INTO skills_category (
  //             title, description, thumbnail, status
  //             ) VALUES ($1, $2, $3, $4)
  //             RETURNING *
  //             `,
  //       [title, description, thumbnail, status]
  //     );

  //     return result.rows[0];
  //   }

  static async addSkillCategory(data, thumbnail) {
    const { title, description } = data;
    const skillCategory = new SkillCategory({
      title,
      description,
      thumbnail,
      status: "published",
    });

    return await skillCategory.save();
  }
  static async checkUserExist(phone, email) {
    return await User.findOne({
      $or: [{ phone }, { email }],
    });
  }

  static async updateUser(userId, updates) {
    const { email, firstname, lastname, gender, password } = updates;
    const hashedPassword = password
      ? await bcrypt.hash(password, 10)
      : undefined;

    const updateData = {
      ...(email && { email }),
      ...(firstname && { firstname }),
      ...(lastname && { lastname }),
      ...(gender && { gender }),
      ...(hashedPassword && { password: hashedPassword }),
    };

    return await User.findByIdAndUpdate(userId, updateData, { new: true });
  }
}

module.exports = Admin;
