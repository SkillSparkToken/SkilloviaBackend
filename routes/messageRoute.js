const express = require('express');
const { retrieveMessage, sendMessage, markAsRead, retrieveChatUsers } = require('../controllers/messageController');
const verify = require("../middlewares/verifyToken")
const router = express.Router();


router.post('/', verify, sendMessage);
router.get('/:senderId/:receiverId', verify, retrieveMessage);
router.put('/markasread/:messageId', verify, markAsRead);
router.get('/chat/history/users', verify, retrieveChatUsers);

module.exports = router;