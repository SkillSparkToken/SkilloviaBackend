const { stat } = require("fs/promises");

// models/User.js
const mongoose = require("mongoose");
const ObjectId = mongoose.Types.ObjectId;
const bcrypt = require("bcrypt");

const userSchema = new mongoose.Schema(
  {
    firstname: { type: String },
    lastname: { type: String },
    fullname: { type: String }, // if you need it
    email: {
      type: String,
      // required: true,
      // unique: true,
    },
    phone: {
      type: String,
      // required: true,
      // unique: true,
    },
    gender: { type: String },
    location: { type: String },
    street: { type: String },
    zip_code: { type: String },
    lat: { type: Number },
    lon: { type: Number },
    referred_by: { type: String },
    website: { type: String },

    password: {
      type: String,
      // required: true,
      minlength: 8,
    },
    referral_code: { type: String },
    referred_by: { type: String },
    photourl: { type: String, default: null },
    refreshToken: { type: String, default: null },
    is_email_verified: { type: Boolean, default: false },
  },
  { timestamps: true }
);

// Static method to create a user
userSchema.statics.createUser = async function (data) {
  const { phone, email, firstname, lastname, gender, password, referred_by } =
    data;

  const hashedPassword = await bcrypt.hash(password, 10);
  const code = Math.floor(1000 + Math.random() * 900000);
  const referralCode = firstname + code;

  const user = new this({
    phone,
    email,
    firstname,
    lastname,
    gender,
    password: hashedPassword,
    is_email_verified: true, // same as 1 in PG
    referral_code: referralCode,
    referred_by,
  });

  return await user.save();
};

// In your Mongoose User model file (e.g., User.js)

userSchema.statics.findByEmail = async function (email) {
  return await this.findOne({ email });
};

userSchema.statics.findByPhone = async function (phone) {
  return await this.findOne({ phone });
};

userSchema.statics.storeRefreshToken = async function (userId, token) {
  return await this.findByIdAndUpdate(userId, { refreshToken: token });
};

userSchema.statics.updateCoordinates = async function (
  lat,
  lon,
  accuracy,
  location_updated_at,
  userId
) {
  return await this.findByIdAndUpdate(userId, {
    lat,
    lon,
    accuracy,
    location_updated_at,
  });
};
userSchema.statics.getRefreshToken = async function (token) {
  return await this.findOne({ refreshToken: token });
};

userSchema.statics.resetPassword = async function (userId, password) {
  return await this.findByIdAndUpdate(userId, { password }, { new: true });
};

userSchema.statics.changeNotificationType = async function (userId, type) {
  return await this.findByIdAndUpdate(
    userId,
    { notification_type: type },
    { new: true }
  );
};

userSchema.statics.changeAppearanceMode = async function (userId, mode) {
  return await this.findByIdAndUpdate(
    userId,
    { appearance_mode: mode },
    { new: true }
  );
};
userSchema.statics.getProfileByUserId = async function (id) {
  const [profile] = await this.aggregate([
    { $match: { _id: new ObjectId(id) } },

    {
      $lookup: {
        from: "skills",
        localField: "_id",
        foreignField: "userId",
        as: "skills",
      },
    },
    {
      $lookup: {
        from: "accounts",
        localField: "_id",
        foreignField: "userId",
        as: "account",
      },
    },
    {
      $lookup: {
        from: "follows",
        let: { userId: "$_id" },
        pipeline: [
          { $match: { $expr: { $eq: ["$followingId", "$$userId"] } } },
          { $count: "count" },
        ],
        as: "followers",
      },
    },
    {
      $lookup: {
        from: "follows",
        let: { userId: "$_id" },
        pipeline: [
          { $match: { $expr: { $eq: ["$followerId", "$$userId"] } } },
          { $count: "count" },
        ],
        as: "following",
      },
    },
    {
      $lookup: {
        from: "kycs",
        localField: "_id",
        foreignField: "user_id",
        as: "kyc_docs",
      },
    },
    {
      $lookup: {
        from: "billing_methods",
        localField: "_id",
        foreignField: "user_id",
        as: "billing_methods_data",
      },
    },
    {
      $lookup: {
        from: "stripe_accounts",
        localField: "_id",
        foreignField: "user_id",
        as: "stripe_account_data",
      },
    },
    {
      $project: {
        phone: 1,
        email: 1,
        firstname: 1,
        lastname: 1,
        gender: 1,
        notification_type: 1,
        appearance_mode: 1,
        photourl: 1,
        bio: 1,
        location: 1,
        street: 1,
        zip_code: 1,
        created_at: 1,
        updated_at: 1,
        referral_code: 1,
        website: 1,

        skills: {
          $map: {
            input: "$skills",
            as: "skill",
            in: {
              skill_id: "$$skill._id",
              description: "$$skill.description",
              skill_type: "$$skill.skill_type",
              spark_token: "$$skill.spark_token",
              experience_level: "$$skill.experience_level",
              hourly_rate: "$$skill.hourly_rate",
              thumbnail01: "$$skill.thumbnail01",
              thumbnail02: "$$skill.thumbnail02",
              thumbnail03: "$$skill.thumbnail03",
              thumbnail04: "$$skill.thumbnail04",
            },
          },
        },

        spark_token_balance: {
          $ifNull: [{ $arrayElemAt: ["$account.spark_token_balance", 0] }, 0],
        },
        cash_balance: {
          $ifNull: [{ $arrayElemAt: ["$account.cash_balance", 0] }, 0],
        },

        total_followers: {
          $ifNull: [{ $arrayElemAt: ["$followers.count", 0] }, 0],
        },
        total_following: {
          $ifNull: [{ $arrayElemAt: ["$following.count", 0] }, 0],
        },
        iskyc: { 
          $gt: [{ $size: "$kyc_docs" }, 0] 
        },
        isPaymentMethod: { 
          $gt: [{ $size: "$billing_methods_data" }, 0] 
        },
        isStripeLinked: { 
          $gt: [{ $size: "$stripe_account_data" }, 0] 
        },
      },
    },
  ]);

  return profile;
};
// Example usage inside a controller or service:

userSchema.statics.getProfileByUserName = async function (name) {
  const mongoose = require("mongoose");
  const ObjectId = mongoose.Types.ObjectId;

  const [profile] = await this.aggregate([
    {
      $addFields: {
        fullName: { $concat: ["$firstname", " ", "$lastname"] },
      },
    },
    {
      $match: {
        fullName: { $regex: new RegExp(name, "i") }, // case-insensitive search
      },
    },
    {
      $lookup: {
        from: "skills",
        localField: "_id",
        foreignField: "userId",
        as: "skills",
      },
    },
    {
      $lookup: {
        from: "accounts",
        localField: "_id",
        foreignField: "userId",
        as: "account",
      },
    },
    {
      $lookup: {
        from: "follows",
        let: { userId: "$_id" },
        pipeline: [
          { $match: { $expr: { $eq: ["$followingId", "$$userId"] } } },
          { $count: "count" },
        ],
        as: "followers",
      },
    },
    {
      $lookup: {
        from: "follows",
        let: { userId: "$_id" },
        pipeline: [
          { $match: { $expr: { $eq: ["$followerId", "$$userId"] } } },
          { $count: "count" },
        ],
        as: "following",
      },
    },
    {
      $project: {
        firstname: 1,
        lastname: 1,
        email: 1,
        phone: 1,
        bio: 1,
        location: 1,
        photourl: 1,
        created_at: 1,
        updated_at: 1,

        skills: {
          $map: {
            input: "$skills",
            as: "skill",
            in: {
              skill_id: "$$skill._id",
              description: "$$skill.description",
              skill_type: "$$skill.skill_type",
              spark_token: "$$skill.spark_token",
              experience_level: "$$skill.experience_level",
              hourly_rate: "$$skill.hourly_rate",
              thumbnail01: "$$skill.thumbnail01",
              thumbnail02: "$$skill.thumbnail02",
              thumbnail03: "$$skill.thumbnail03",
              thumbnail04: "$$skill.thumbnail04",
            },
          },
        },

        spark_token_balance: {
          $ifNull: [{ $arrayElemAt: ["$account.spark_token_balance", 0] }, 0],
        },
        cash_balance: {
          $ifNull: [{ $arrayElemAt: ["$account.cash_balance", 0] }, 0],
        },

        total_followers: {
          $ifNull: [{ $arrayElemAt: ["$followers.count", 0] }, 0],
        },
        total_following: {
          $ifNull: [{ $arrayElemAt: ["$following.count", 0] }, 0],
        },
      },
    },
  ]);

  return profile;
};
userSchema.statics.changeAvatar = async function (userId, filepath) {
  return await this.findByIdAndUpdate(
    userId,
    { photourl: filepath },
    { new: true }
  );
};
userSchema.statics.updateBio = async function (userId, data) {
  const updateFields = {};
  const allowedFields = ["bio", "location", "street", "zip_code", "lon", "lat"];

  allowedFields.forEach((field) => {
    if (data[field] !== undefined) {
      updateFields[field] = data[field];
    }
  });

  return await this.findByIdAndUpdate(userId, updateFields, { new: true });
};

userSchema.statics.updateVerificationStatus = async function (email, status) {
  return await this.findOneAndUpdate(
    { email },
    { is_email_verified: status },
    { new: true }
  );
};

userSchema.statics.deleteUser = async function (email) {
  return await this.findOneAndDelete({ email });
};

userSchema.statics.updateCoordinates = async function (
  lat,
  lng,
  radius,
  date,
  userId
) {
  const updateFields = {
    ...(lat !== undefined && { lat }),
    ...(lng !== undefined && { lon: lng }),
    ...(radius !== undefined && { radius }),
    ...(date !== undefined && { location_updated_at: date }),
  };

  return await this.findByIdAndUpdate(userId, updateFields, { new: true });
};

userSchema.statics.findNearbyUsers = async function (lat, lon, radiusInKm = 5) {
  return await this.aggregate([
    {
      $geoNear: {
        near: { type: "Point", coordinates: [lon, lat] },
        distanceField: "distance",
        spherical: true,
        maxDistance: radiusInKm * 1000, // convert km to meters
      },
    },
    {
      $project: {
        id: 1,
        firstname: 1,
        lastname: 1,
        email: 1,
        phone: 1,
        gender: 1,
        photourl: 1,
        lat: "$location.coordinates.1",
        lon: "$location.coordinates.0",
        distance: 1,
      },
    },
    { $sort: { distance: 1 } },
  ]);
};
userSchema.statics.findNearbyUsersByAddress = async function (address) {
  const regex = new RegExp(address, "i"); // case-insensitive regex
  return await this.find({
    $or: [{ location: { $regex: regex } }, { street: { $regex: regex } }],
  }).select("id firstname lastname lat lon email phone gender photourl");
};

userSchema.statics.getAllUsers = async function () {
  return await this.find();
};

userSchema.statics.setReferralCode = async function (userId, code) {
  return await this.findOneAndUpdate(
    { _id: userId, referral_code: { $exists: false } },
    { referral_code: code },
    { new: true }
  );
};

userSchema.statics.getUsersByReferralCode = async function (code) {
  return await this.find({ referred_by: code });
};

userSchema.statics.update = async function (userId, updates) {
  const {
    email,
    firstname,
    lastname,
    gender,
    password,
    location,
    street,
    zip_code,
    lat,
    lon,
    referred_by,
    website,
  } = updates;

  const hashedPassword = password ? await bcrypt.hash(password, 10) : undefined;

  // Build update object, only include fields that are not undefined
  const updateData = {};

  if (email !== undefined) updateData.email = email;
  if (firstname !== undefined) updateData.firstname = firstname;
  if (lastname !== undefined) updateData.lastname = lastname;
  if (gender !== undefined) updateData.gender = gender;
  if (hashedPassword !== undefined) updateData.password = hashedPassword;
  if (location !== undefined) updateData.location = location;
  if (street !== undefined) updateData.street = street;
  if (zip_code !== undefined) updateData.zip_code = zip_code;
  if (lat !== undefined) updateData.lat = lat;
  if (lon !== undefined) updateData.lon = lon;
  if (referred_by !== undefined) updateData.referred_by = referred_by;
  if (website !== undefined) updateData.website = website;

  // Update the document and return the updated document
  const updatedUser = await this.findByIdAndUpdate(
    userId,
    { $set: updateData },
    { new: true } // return the updated doc
  );

  return updatedUser;
};

// Static method
userSchema.statics.checkUserExist = async function (phone, email) {
  return await this.findOne({
    $or: [{ phone }, { email }],
  });
};

// Optional: add checkUserExist, findByEmail, etc. here

const User = mongoose.model("User", userSchema);
module.exports = User;
