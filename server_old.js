require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const skillRoutes = require('./routes/skillRoutes');
const suggestskillRoutes = require('./routes/suggestskillRoutes');
const followRoutes = require('./routes/followRoutes');
const settingsRoute = require('./routes/settingsRoute');
const messageRoute = require('./routes/messageRoute');

const passport = require('passport');
const session = require('express-session');
const http = require("http");
const { Server } = require("socket.io");
require('./passport');
const chatSocketHandler = require("./sockets/chat");


const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

app.use(session({ secret: process.env.GOOGLE_CLIENT_SECRET, resave: false, saveUninitialized: true }));
app.use(passport.initialize());
app.use(passport.session());

const server = http.createServer(app);
const io = new Server(server);

// Socket.IO
chatSocketHandler(io);

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/skills', skillRoutes);
app.use('/api/suggestedskills', suggestskillRoutes);
app.use('/api/follows', followRoutes);
app.use('/api/settings', settingsRoute);
app.use('/api/message', messageRoute);

// Server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
