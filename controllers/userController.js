const User = require('../models/User');

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
      return res.status(404).json({ status: 'error', message: 'User profile not found.' });
    }

    const { id, phone, email, firstname, lastname, gender, password, notification_type, appearance_mode, created_at, updated_at } = data[0];

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
      password,
      notification_type,
      appearance_mode,
      created_at,
      updated_at,
      skills,
    };

    res.status(200).json({ status: 'success', message: 'User profile retrieved successfully.', data: userProfile });
  } catch (error) {
    res.status(500).json({ status: 'error', message: 'Failed to retrieve profile.' });
  }
};

