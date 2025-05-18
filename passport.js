const jwt = require("jsonwebtoken");
const passport = require("passport");
const GoogleStrategy = require("passport-google-oauth20").Strategy;
const pool = require("./config/db");
const createWalletForUser = require("./utils/createWalletUtils");

// Serialize the user
passport.serializeUser((user, done) => {
  done(null, user.id); // Save only the user ID in the session
});

// Deserialize the user
passport.deserializeUser(async (id, done) => {
  try {
    const res = await pool.query("SELECT * FROM users WHERE id = $1", [id]);
    if (res.rows.length > 0) {
      done(null, res.rows[0]);
    } else {
      done(new Error("User not found"), null);
    }
  } catch (err) {
    done(err, null);
  }
});

// Google OAuth Strategy
passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      callbackURL: process.env.CALLBACK_URL,
    },
    async (accessToken, refreshToken, profile, done) => {
      try {
        let user;

        // Check if the user already exists and has a google_id associated
        const res = await pool.query("SELECT * FROM users WHERE email = $1", [
          profile.emails[0].value,
        ]);

        if (res.rows.length > 0) {
          user = res.rows[0];

          // If the user doesn't have a google_id, associate the google account
          if (!user.google_id) {
            user = await pool.query(
              "UPDATE users SET google_id = $1 WHERE id = $2 RETURNING *",
              [profile.id, user.id]
            );
            user = user.rows[0]; // Get the updated user record
          }
        } else {
          // Create a new user and associate the Google account
          const newUser = await pool.query(
            "INSERT INTO users (google_id, firstname, lastname, email, photourl) VALUES ($1, $2, $3, $4, $5) RETURNING *",
            [
              profile.id,
              profile.name.givenName,
              profile.name.familyName,
              profile.emails[0].value,
              profile.photos[0].value,
            ]
          );
          user = newUser.rows[0];
        }
        // ✅ Create wallet if it doesn't exist
        await createWalletForUser(user.id);

        // Generate JWT token for the user
        const token = jwt.sign(
          {
            id: user.id,
            email: user.email,
            lat: user.lat,
            lon: user.lon,
            role_id: user.role_id,
          },
          process.env.ACCESS_TOKEN_SECRET,
          { expiresIn: "1h" } // 1 hour expiration for access token
        );

        // Attach token to user object
        user.token = token;

        // Pass the user object with the token back to the callback
        done(null, user);
      } catch (err) {
        done(err, null);
      }
    }
  )
);
