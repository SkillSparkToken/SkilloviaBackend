const Messages = require('../models/Messages');
  
// for testing purposes
exports.sendMessage = async (req, res) => {
    try {
        if(req.body.senderId != null && req.body.receiverId != null && req.body.content != null){

            const message = await Messages.store(req.body);
            res.status(200).json({ status: 'success', message: 'messages sent successfully.', data: message });
        } else {
            res.status(200).json({ status: 'failed', message: 'Missing parameter', data: null });
        }
    
    } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve messages', data: error });
    }
};


exports.retrieveMessage = async (req, res) => {
    const senderId = parseInt(req.params.senderId)  
    const receiverId = parseInt(req.params.receiverId)  

    try {
        if(senderId != null && receiverId != null){
            const message = await Messages.retrieveMessage(senderId, receiverId);
            res.status(200).json({ status: 'success', message: 'messages retrieved successfully.', data: message });
        } else {
            res.status(200).json({ status: 'failed', message: 'Missing parameter', data: null });
        }
    
    } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve messages', data: error });
    }
};


exports.markAsRead = async (req, res) => {
    const messageId = parseInt(req.params.messageId)   

    try {
        if(messageId != null){
            const message = await Messages.markAsRead(messageId);
            res.status(200).json({ status: 'success', message: 'messages updated successfully.', data: message });
        } else {
            res.status(200).json({ status: 'failed', message: 'Missing parameter', data: null });
        }
    
    } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update messages', data: error });
    }
};


exports.retrieveChatUsers = async (req, res) => {
    const userId = req.user.id;

    try {
        if (userId != null) {
            const chatUsers = await Messages.retrieveChatUsers(userId);
            res.status(200).json({status: 'success', message: 'Chat users with details retrieved successfully.', data: chatUsers});
        } else {
            res.status(400).json({status: 'failed', message: 'Missing or invalid parameter.', data: null});
        }
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to retrieve chat users with details.', data: error.message});
    }
};
  
  