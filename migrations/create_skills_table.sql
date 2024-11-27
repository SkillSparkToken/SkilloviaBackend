CREATE TABLE skills (
  id SERIAL PRIMARY KEY,
  user_id SERIAL,
  skill_type VARCHAR(255),
  experience_level VARCHAR(80),
  hourly_rate VARCHAR(10),
  spark_token VARCHAR(10),
  description TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
