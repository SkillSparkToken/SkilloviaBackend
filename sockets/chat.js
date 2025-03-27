const Messages = require('../models/Messages');

const chatSocketHandler = (io) => {
    io.on("connection", (socket) => {
        console.log("User connected:", socket.id);

        // Join a room
        socket.on("joinRoom", (userId) => {
            socket.join(userId.toString());
            console.log(`User ${userId} joined room ${userId}`);
        });

        // Send message
        socket.on("sendMessage", async (message) => {
            //const { senderId, receiverId, content } = message;
            try {
                // Save message to the database
                const result = await Messages.store(message);

                // Emit the message to the receiver
                socket.to(receiverId.toString()).emit("receiveMessage", result);
            } catch (error) {
                console.error("Error saving message:", error);
            }
        });

        // Handle disconnection
        socket.on("disconnect", () => {
            console.log("User disconnected:", socket.id);
        });
    });
};

module.exports = chatSocketHandler;
