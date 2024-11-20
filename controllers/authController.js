const User = require('../models/User');
const bcrypt = require('bcrypt');


exports.registerUser = async (req, res) => {
  const { phone, password } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await User.create(phone, hashedPassword);

    res.status(201).json({ message: 'User registered successfully.', user });
  } catch (error) {
    res.status(500).json({ error: 'Registration failed.' });
  }
};
