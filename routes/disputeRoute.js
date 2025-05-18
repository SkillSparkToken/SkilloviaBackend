const express = require("express");
const router = express.Router();
const verify = require("../middlewares/verifyToken");
const multer = require("multer");
const multerS3 = require("multer-s3");
const { S3Client } = require("@aws-sdk/client-s3");
const {
  openDispute,
  getUserDisputes,
  getAllDisputes,
} = require("../controllers/disputeController");

// S3 Setup
const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  },
});

const upload = multer({
  storage: multerS3({
    s3,
    bucket: "skillovia",
    metadata: (req, file, cb) => {
      cb(null, { fieldName: file.fieldname });
    },
    key: (req, file, cb) => {
      const uniqueFilename = `uploads/disputes/${Date.now()}-${
        file.originalname
      }`;
      cb(null, uniqueFilename);
    },
  }),
  limits: { fileSize: 10 * 1024 * 1024 }, // 10MB limit
});

// Routes
router.post("/open", verify, upload.single("file"), openDispute);
router.get("/user", verify, getUserDisputes);
router.get("/all", verify, getAllDisputes);

module.exports = router;
