CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  phone VARCHAR(15) UNIQUE NOT NULL,
  email VARCHAR(255),
  firstname VARCHAR(50),
  lastname VARCHAR(50),
  gender VARCHAR(10),
  password TEXT NOT NULL,
  notification_type ENUM('sms', 'email') NOT NULL DEFAULT 'sms',
  appearance_mode ENUM('light', 'dark', 'system') NOT NULL DEFAULT 'system'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
