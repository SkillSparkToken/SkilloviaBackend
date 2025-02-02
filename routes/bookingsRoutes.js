const express = require('express');
const {createBookings, updateBookings, rejectBookings, acceptBookings,
    getInwardBookingsByUserId, getOutwardBookingsByUserId, removeBookings
} = require('../controllers/bookingsController');
const router = express.Router();
const verify = require("../middlewares/verifyToken")
const multer = require('multer');
const fs = require('fs');
const path = require('path');

const storage = multer.diskStorage({
  destination: function (req, file, callback) {
     const uploadDir = '/uploads/files';
     
     callback(null, __dirname + uploadDir);
  },
  filename: function (req, file, callback) {
     const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
     const filename = uniqueSuffix + path.extname(file.originalname);
     const filePath = path.join(__dirname + '/uploads/files', filename);

     // Store the file path in req
     if (!req.filePaths) {
        req.filePaths = null;
     }
     req.filePaths = filePath;

     callback(null, filename);
  }
});

const upload = multer({ storage: storage })

router.post('/', verify, upload.single('file'), createBookings);
router.put('/:id', verify, upload.single('file'), updateBookings);
router.put('/reject/:id', verify, rejectBookings);
router.put('/accept/:id', verify, acceptBookings);
router.get('/get/user/inward', verify, getInwardBookingsByUserId);
router.get('/get/user/outward', verify, getOutwardBookingsByUserId);
router.delete('/:id', verify, removeBookings);


module.exports = router;
