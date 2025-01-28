const User = require('../models/User');
const bcrypt = require('bcrypt');

exports.updateUser = async (req, res) => {
  const userId = req.params.id;
  const updates = req.body;

  try {
    const updatedUser = await User.update(userId, updates);
    res.status(200).json({ status: 'success', message: 'User updated successfully.', data: updatedUser });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update user.' });
  }
};


exports.changeNotificationType = async (req, res) => {
  const userId = req.user.id;
  const {notification_type} = req.body;

  try {
    const updatedNotification = await User.changeNotificationType(userId, notification_type);
    res.status(200).json({ status: 'success', message: 'Notification type updated successfully.', data: updatedNotification });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update notification type.' });
  }
};


exports.changeAppearanceMode = async (req, res) => {
  const userId = req.user.id;
  const {appearance_mode} = req.body;

  try {
    const mode = await User.changeAppearanceMode(userId, appearance_mode);
    res.status(200).json({ status: 'success', message: 'Appearance mode updated successfully.', data: mode });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update appearance mode.' });
  } 
};


exports.getProfileByUserId = async (req, res) => {
  const userId = parseInt(req.params.id);

  try {
    const data = await User.getProfileByUserId(userId);

    if (data.length === 0) {
      return res.status(404).json({ status: 'error', message: 'User profile not found.', data: data });
    }

    const { id, phone, email, firstname, lastname, gender, notification_type, appearance_mode, photourl, bio, spark_token_balance, cash_balance, total_followers, total_following, location, street, zip_code, created_at, updated_at } = data[0];

    // Map skills to an array
    const skills = data.map((item) => ({
      description: item.description,
      skill_type: item.skill_type,
      experience_level: item.experience_level,
      hourly_rate: item.hourly_rate,
    }));

    const userProfile = {
      id,
      phone,
      email,
      firstname,
      lastname,
      gender,
      notification_type,
      appearance_mode,
      photourl,
      bio,
      spark_token_balance, 
      cash_balance, 
      total_followers, 
      total_following,
      location, 
      street, 
      zip_code,
      created_at,
      updated_at,
      skills,
    };

    res.status(200).json({ status: 'success', message: 'User profile retrieved successfully.', data: userProfile });
  } catch (error) {
    res.status(500).json({ status: 'error', message: 'Failed to retrieve profile.' });
  }
};


exports.profilePhotoUpload = async (req, res) => {
  const userId = req.user.id;
  
  if(req.filePaths != null){
    const filePath = req.filePaths;
    //console.log("PTH ", filePath)
    const file = filePath.slice(15);
    
    try {
      const mode = await User.changeAvatar(userId, file);
      res.status(200).json({ status: 'success', message: 'Profile photo updated successfully', data: mode });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to upload photo' });
    } 
    
  } else {
      res.status(400).send({
          status: 'error',
          message: 'No image found',
          data: null
      });
  }
};


exports.profilePhotoUploadS3 = async (req, res) => {
  const userId = req.user.id;
  const filePath = req.file.location;
  
  if(filePath != null){
    //console.log("PTH ", filePath)
    
    try {
      const mode = await User.changeAvatar(userId, filePath);
      res.status(200).json({ status: 'success', message: 'Profile photo updated successfully', data: mode });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to upload photo' });
    } 
    
  } else {
      res.status(400).send({
          status: 'error',
          message: 'No image found',
          data: null
      });
  }
};


exports.updateBio = async (req, res) => {
  const userId = req.user.id;
  
  try {
    const mode = await User.updateBio(userId, req.body);
    res.status(200).json({ status: 'success', message: 'Bio updated successfully', data: mode });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update bio' });
  }
};


exports.changePassword = async (req, res) => {
  const userId = req.user.id //parseInt(req.params.id);
  const {password, newPassword} = req.body

  if(password != null && newPassword != null){
    try {
      const user = await User.findById(userId);
      
      const validPass = await bcrypt.compare(password, user.password)
      if(!validPass) {
          return res.status(400).send({
              status: 'error',
              message: 'Invalid password',
              data: null
          }); 
      } 
  
      const hashedPassword = newPassword ? await bcrypt.hash(newPassword, 10) : null;
      const data = await User.resetPassword(userId, hashedPassword);
  
      res.status(201).json({ status: 'success', message: 'Password reset was successful', data: data });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Password reset failed.' });
    }
  } else {
    return res.status(400).send({
      status: 'error',
      message: 'missing parameters',
      data: null
    });
  }
};


exports.nearByUsers = async (req, res) => {
  const userId = req.user.id;
  const lat = req.params.lat;
  const lon = req.params.lon;

  if (!lat || !lon) {
    return res.status(400).send({
      status: 'error',
      message: 'Latitude and longitude are required',
      data: null
    });
  }
  const rad = 5
  try {
    const users = await User.findNearbyUsers(parseFloat(lat), parseFloat(lon), parseFloat(rad));
    res.status(200).json({ status: 'success', message: 'Nearby users retrieved successful', data: users });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching nearby users', error: error.message });
  }
};


exports.nearByUsers2 = async (req, res) => {
  const userId = req.user.id;
  const {lat, lon, radius} = req.body;

  if (!lat || !lon) {
    return res.status(400).send({
      status: 'error',
      message: 'Latitude and longitude are required',
      data: null
    });
  }
  const rad = 5
  try {
    const users = await User.findNearbyUsers(parseFloat(lat), parseFloat(lon), parseFloat(rad));
    res.status(200).json({ status: 'success', message: 'Nearby users retrieved successful', data: users });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching nearby users', error: error.message });
  }
};

