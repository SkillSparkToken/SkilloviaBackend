const express = require("express");
const {
  createSkill,
  updateSkill,
  deleteSkill,
  retrievePublishedSkill,
  searchSkillsByName,
  searchSkillsByCreatorName,
  searchSkillsBySparktoken,
  updatePublishedStatus,
  retrieveUserSkill,
  deleteSkillPhoto,
  searchSkillsByType,
  getSkillCategory,
  searchUsersBySkillType,
} = require("../controllers/skillController");
const router = express.Router();
const verify = require("../middlewares/verifyToken");
const multer = require("multer");
const fs = require("fs");
const path = require("path");
const AWS = require("aws-sdk");
const multerS3 = require("multer-s3");
const { S3Client } = require("@aws-sdk/client-s3");
const upload = require("../middlewares/multerConfig"); // Multer configuration

const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  },
});

// const storage = multer.diskStorage({
//   destination: function (req, file, callback) {
//      const uploadDir = '/uploads/skills';

//      callback(null, __dirname + uploadDir);
//   },
//   filename: function (req, file, callback) {
//      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
//      const filename = uniqueSuffix + path.extname(file.originalname);
//      const filePath = path.join(__dirname + '/uploads/skills', filename);

//      // Store the file path in req
//      if (!req.filePaths) {
//         req.filePaths = null;
//      }
//      req.filePaths = filePath;

//      callback(null, filename);
//   }
// });

// const upload = multer({ storage: storage })

// Configure Multer to Upload to S3
// const upload = multer({
//   storage: multerS3({
//     s3: s3,
//     bucket: "skillovia", // Replace with your actual S3 bucket name
//     metadata: (req, file, cb) => {
//       cb(null, { fieldName: file.fieldname });
//     },
//     key: (req, file, cb) => {
//       const uniqueFilename = `uploads/skills/${Date.now()}-${
//         file.originalname
//       }`;
//       cb(null, uniqueFilename);
//     },
//   }),
//   limits: { fileSize: 5 * 1024 * 1024 }, // Limit to 5MB per file
// });
// router.post("/", verify, upload.array("thumbnails", 4), createSkill);
// router.post(
//   "/",
//   verify,
//   upload.fields([{ name: "thumbnails", maxCount: 4 }]), // Handle file uploads
//   async (req, res) => {
//     try {
//       await createSkill(req, res);
//     } catch (err) {
//       console.error(err);
//       res.status(500).json({ error: "Internal Server Error" });
//     }
//   }
// );
router.post(
  "/",
  verify,
  upload.fields([{ name: "thumbnails", maxCount: 4 }]), // Handle file uploads
  async (req, res) => {
    try {
      await createSkill(req, res);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }
);
router.put("/:id", verify, upload.array("thumbnails", 4), updateSkill);
router.delete("/:id", verify, deleteSkill);
router.put("/publish/:id", verify, updatePublishedStatus);
router.get("/", verify, retrievePublishedSkill);
router.get("/searchname/:term", verify, searchSkillsByName);
router.get("/searchcreator/:term", verify, searchSkillsByCreatorName);
router.get("/searchsparktoken/:term", verify, searchSkillsBySparktoken);
router.get("/search/type/:term", verify, searchSkillsByType);
router.get("/search/type/users/:term", verify, searchUsersBySkillType);
router.get("/user/all", verify, retrieveUserSkill);
router.delete("/photo/:id", verify, deleteSkillPhoto);
router.get("/get/categories", verify, getSkillCategory);

module.exports = router;
