const pool = require('../config/db');
const bcrypt = require('bcrypt');

class User {
    static async follow(userId, follower_id) {
        const result = await pool.query(
        'INSERT INTO follows (following_id, follower_id) VALUES ($1,$2) RETURNING *',
        [userId, follower_id]
        );
        return result.rows[0];
    }


    static async unfollow(userId, follower_id) {
        const result = await pool.query(
            `DELETE FROM follows 
             WHERE following_id = $1 AND follower_id = $2 
             RETURNING *`,
            [userId, follower_id]
        );
    
        return result.rows[0];
    }


    static async checkFollower(userId, follower_id) {
        const result = await pool.query(
        'SELECT * FROM follows WHERE following_id = $1 AND follower_id = $2',
        [userId, follower_id]
        );
        return result.rows[0];
    }


    static async getFollowers(userId) {
        const result = await pool.query(
            `
            SELECT 
                follows.id, 
                users.id AS follower_id, 
                (users.firstname || ' ' || users.lastname) AS follower_name, 
                users.email AS follower_email,
                users.photourl,
                users.phone,
                follows.created_at AS date
            FROM follows 
            INNER JOIN users ON follows.follower_id = users.id
            WHERE follows.following_id = $1
            `,
            [userId]
        );
        return result.rows;
    }


    static async getFollowings(userId) {
        const result = await pool.query(
            `
            SELECT 
                follows.id, 
                users.id AS following_id, 
                (users.firstname || ' ' || users.lastname) AS following_name, 
                users.email AS following_email,
                users.photourl,
                users.phone,
                follows.created_at AS date
            FROM follows 
            INNER JOIN users ON follows.following_id = users.id
            WHERE follows.follower_id = $1
            `,
            [userId]
        );
        return result.rows;
    }

}

module.exports = User;
