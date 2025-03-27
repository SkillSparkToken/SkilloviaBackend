CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  google_id SERIAL
  phone VARCHAR(15) UNIQUE NOT NULL,
  email VARCHAR(255),
  firstname VARCHAR(50),
  lastname VARCHAR(50),
  gender VARCHAR(10),
  password TEXT NOT NULL,
  bio TEXT,
  location VARCHAR(500),
  street VARCHAR(500),
  zip_code VARCHAR(30),
  lat VARCHAR(255),
  lon VARCHAR(255),
  radius VARCHAR(50)
  notification_type ENUM('sms', 'email') NOT NULL DEFAULT 'sms',
  appearance_mode ENUM('light', 'dark', 'system') NOT NULL DEFAULT 'system',
  photourl VARCHAR(255),
  verification_code VARCHAR(10),
  is_email_verified INTEGER,
  role_id INTEGER,
  referred_by VARCHAR(50),
  referral_code VARCHAR(50),
  website VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
