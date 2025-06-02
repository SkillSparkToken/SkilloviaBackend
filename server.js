require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const session = require("express-session");
const passport = require("passport");
const http = require("http");
const { Server } = require("socket.io");
const MongoStore = require("connect-mongo");
const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes");
const walletRoute = require("./routes/walletRoute");
const reviewRoutes = require("./routes/reviewRoutes");
const disputeRoute = require("./routes/disputeRoute");
const skillRoutes = require("./routes/skillRoutes");
const notificationRoute = require("./routes/notificationRoute");
const suggestskillRoutes = require("./routes/suggestskillRoutes");
const followRoutes = require("./routes/followRoutes");
const settingsRoute = require("./routes/settingsRoute");
const messageRoute = require("./routes/messageRoute");
const adminRoutes = require("./routes/adminRoutes");
const bookingsRoutes = require("./routes/bookingsRoutes");
const chatSocketHandler = require("./sockets/chat");
const cookieParser = require("cookie-parser");
require("./passport");

const app = express();
// app.use(cookieParser());
const allowedOrigins = [
  "http://localhost:3000",
  "http://localhost:5173",
  "http://localhost:19006",
  "http://localhost:5172",
  "https://skilloviaweb.vercel.app",
  "https://skillovia.co.uk",
  "https://admin.skillovia.com",
  "https://skillovia.com",
  "https://www.skillovia.co.uk",
  "https://www.skillovia.com",
  "https://skilloviaadmin.vercel.app",
  "https://www.skilloviaadmin.vercel.app",
];

app.use(
  cors({
    origin: (origin, callback) => {
      // Allow requests with no origin (like React Native) or from allowed origins
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error("Not allowed by CORS"));
      }
    },
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"],
    credentials: true, // Allow cookies and credentials
    allowedHeaders: [
      "Content-Type",
      "Authorization",
      "Origin",
      "Accept",
      "X-Requested-With",
    ],
  })
);

app.use(cookieParser());

app.options("*", cors());
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// app.use(
//   session({
//     secret: process.env.GOOGLE_CLIENT_SECRET,
//     resave: false,
//     saveUninitialized: true,
//   })
// );
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    store: MongoStore.create({
      mongoUrl: process.env.MONGODB_URI,
      ttl: 14 * 24 * 60 * 60, // optional: session expires in 14 days
    }),
  })
);

app.use(passport.initialize());
app.use(passport.session());

const server = http.createServer(app);
const io = new Server(server);

// Socket.IO
chatSocketHandler(io);

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/users", userRoutes);
app.use("/api/reviews", reviewRoutes);
app.use("/api/", walletRoute);
app.use("/api/skills", skillRoutes);
app.use("/api/notifications", notificationRoute);
app.use("/api/suggestedskills", suggestskillRoutes);
app.use("/api/follows", followRoutes);
app.use("/api/settings", settingsRoute);
app.use("/api/message", messageRoute);
app.use("/api/dispute", disputeRoute);
app.use("/api/admin", adminRoutes);
app.use("/api/bookings", bookingsRoutes);

// Server
const PORT = process.env.PORT || 5001;
// server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
const mongoose = require("mongoose");

mongoose
  .connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("✅ MongoDB connected");

    // Start server only after DB connection
    const PORT = process.env.PORT || 5001;
    server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
  })
  .catch((err) => {
    console.error("❌ MongoDB connection error:", err);
  });
