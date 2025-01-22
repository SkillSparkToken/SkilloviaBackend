const pool = require('../config/db');

class Messages {
    static async store(data) {
        const { senderId, receiverId, content } = data;

        const result = await pool.query(
        'INSERT INTO messages (sender_id, receiver_id, content) VALUES ($1,$2,$3) RETURNING *',
        [senderId, receiverId, content]
        );
        return result.rows[0];
    }


    static async retrieveMessage(senderId, receiverId) {
        const result = await pool.query(
            `SELECT * FROM messages 
             WHERE (sender_id = $1 AND receiver_id = $2) 
                OR (sender_id = $2 AND receiver_id = $1) 
             ORDER BY created_at`,
            [senderId, receiverId]
        );
        return result.rows;
    }


    static async markAsRead(messageId) {
        const result = await pool.query(
          `UPDATE messages 
           SET mark_as_read = COALESCE($1, mark_as_read)
           WHERE id = $2
           RETURNING *`,
          [true, messageId]
        );
        return result.rows[0];
    }


    static async retrieveChatUsers(userId) {
        const result = await pool.query(
            `SELECT DISTINCT 
                u.id AS user_id,
                (u.firstname || ' ' || u.lastname) AS name,
                u.email,
                u.photourl
             FROM messages m
             JOIN users u 
                ON u.id = CASE 
                            WHEN m.sender_id = $1 THEN m.receiver_id
                            ELSE m.sender_id
                          END
             WHERE m.sender_id = $1 OR m.receiver_id = $1`,
            [userId]
        );
        return result.rows;
    }
}


module.exports = Messages;