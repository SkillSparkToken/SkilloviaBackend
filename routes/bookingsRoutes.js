const express = require("express");
const {
  createBookings,
  updateBookings,
  rejectBookings,
  startBooking,
  completeBooking,
  acceptBookings,
  getInwardBookingsByUserId,
  getOutwardBookingsByUserId,
  removeBookings,
} = require("../controllers/bookingsController");
const router = express.Router();
const verify = require("../middlewares/verifyToken");
const multer = require("multer");
const multerS3 = require("multer-s3");
const { S3Client } = require("@aws-sdk/client-s3");
const fs = require("fs");
const path = require("path");

// const storage = multer.diskStorage({
//   destination: function (req, file, callback) {
//      const uploadDir = '/uploads/files';

//      callback(null, __dirname + uploadDir);
//   },
//   filename: function (req, file, callback) {
//      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
//      const filename = uniqueSuffix + path.extname(file.originalname);
//      const filePath = path.join(__dirname + '/uploads/files', filename);

//      // Store the file path in req
//      if (!req.filePaths) {
//         req.filePaths = null;
//      }
//      req.filePaths = filePath;

//      callback(null, filename);
//   }
// });

// const upload = multer({ storage: storage })

// Initialize S3 Client
const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  },
});

// Configure Multer to Upload to S3
const upload = multer({
  storage: multerS3({
    s3: s3,
    bucket: "eduprosolution", // Your S3 bucket name
    metadata: (req, file, cb) => {
      cb(null, { fieldName: file.fieldname });
    },
    key: (req, file, cb) => {
      const uniqueFilename = `uploads/booking/${Date.now()}-${
        file.originalname
      }`;
      cb(null, uniqueFilename);
    },
  }),
  limits: { fileSize: 10 * 1024 * 1024 }, // 10MB file size limit
});

// router.post('/', verify, upload.single('file'), createBookings);
router.post(
  "/",
  verify,
  upload.fields([{ name: "thumbnails", maxCount: 4 }]),
  async (req, res) => {
    try {
      await createBookings(req, res);
    } catch (err) {
      console.error("Error creating booking:", err);
      res
        .status(500)
        .json({ status: "error", message: "Internal Server Error" });
    }
  }
);
router.put("/:id", verify, upload.single("file"), updateBookings);
router.put("/reject/:id", verify, rejectBookings);
router.put("/accept/:id", verify, acceptBookings);
router.put("/in-progress/:id", verify, startBooking);
router.put("/completed/:id", verify, completeBooking);
router.get("/get/user/inward", verify, getInwardBookingsByUserId);
router.get("/get/user/outward", verify, getOutwardBookingsByUserId);
router.delete("/:id", verify, removeBookings);

module.exports = router;
