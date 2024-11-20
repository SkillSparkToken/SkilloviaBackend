const User = require('../models/User');

exports.updateUser = async (req, res) => {
  const userId = req.params.id;
  const updates = req.body;

  try {
    const updatedUser = await User.update(userId, updates);
    res.status(200).json({ message: 'User updated successfully.', updatedUser });
  } catch (error) {
    res.status(500).json({ error: 'Failed to update user.' });
  }
};
