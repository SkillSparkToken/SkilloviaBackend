const jwt = require('jsonwebtoken');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const pool = require('./config/db');


// Serialize the user
passport.serializeUser((user, done) => {
    done(null, user.id); // Save only the user ID in the session
});

// Deserialize the user
passport.deserializeUser(async (id, done) => {
    try {
        const res = await pool.query('SELECT * FROM users WHERE id = $1', [id]);
        if (res.rows.length > 0) {
            done(null, res.rows[0]);
        } else {
            done(new Error('User not found'), null);
        }
    } catch (err) {
        done(err, null);
    }
});

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

                // Check if user exists
                const res = await pool.query('SELECT * FROM users WHERE google_id = $1', [profile.id]);
                if (res.rows.length > 0) {
                    user = res.rows[0];
                } else {
                    // Insert new user into the database
                    const newUser = await pool.query(
                        'INSERT INTO users (google_id, firstname, lastname, email, photourl) VALUES ($1, $2, $3, $4, $5) RETURNING *',
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

                // Generate JWT token
                const token = jwt.sign(
                    { id:user.id, email:user.email, lat:user.lat, lon:user.lon },
                    process.env.ACCESS_TOKEN_SECRET,
                    { expiresIn: '1h' }
                );

                // Attach token to user object
                user.token = token;

                done(null, user);
            } catch (err) {
                done(err, null);
            }
        }
    )
);
