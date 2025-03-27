const multer = require('multer');
const multerS3 = require('multer-s3');
const s3 = require('../config/aws_s3');

const uploads3 = multer({
    storage: multerS3({
        s3: s3,
        bucket: process.env.S3_BUCKET_NAME,
        acl: 'public-read',
        metadata: (req, file, cb) => {
            cb(null, { fieldName: file.fieldname });
        },
        key: (req, file, cb) => {
            const fileName = `profiles/${Date.now()}_${file.originalname}`;
            cb(null, fileName); // Generate unique file name
        }
    })
});

module.exports = uploads3;
