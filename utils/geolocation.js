require('dotenv').config();
const axios = require('axios');

/**
 * Get latitude and longitude from IP address using Google Geolocation API
 * @param {string} ip - The user's IP address
 * @returns {Promise<Object>} - Latitude and Longitude
 */
async function getCoordinatesFromIp(ip) {
  const apiKey = process.env.GOOGLE_GEOLOCATION_API_KEY;

  try {
    const response = await axios.post(
      `https://www.googleapis.com/geolocation/v1/geolocate?key=${apiKey}`,
      {
        considerIp: true, // Use the IP address to estimate location
      }
    );

    if (response.data.location) {
      const { lat, lng } = response.data.location;
      const { accuracy } = response.data;
      return { lat, lng, accuracy};
    } else {
      throw new Error('Unable to fetch location');
    }
  } catch (error) {
    console.error('Error fetching coordinates:', error.message);
    throw error;
  }
}

module.exports = { getCoordinatesFromIp };
