const Bookings = require('../models/Bookings');

exports.createBookings = async (req, res) => {
  const userId = req.user.id;
  const data = req.body;

  if(req.body.title != null){
    let file = null

    if(req.filePaths != null){
        const filePath = req.filePaths;
        file = filePath.slice(15);
    }

    try {
        const bookings = await Bookings.create(userId, data, file);
        res.status(200).json({ status: 'success', message: 'Skill booked successfully.', data: bookings });
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to book skills.', data: error });
    }

  } else {
    res.status(400).send({
        status: 'error',
        message: 'Title is required',
        data: null
    });
  }
};


exports.updateBookings = async (req, res) => {
    const bookingsId = parseInt(req.params.id);
    const data = req.body;
  
    let file = null
    if(req.filePaths != null){
        const filePath = req.filePaths;
        file = filePath.slice(15);
    }
  
    //try {
        const bookings = await Bookings.update(bookingsId, data, file);
        res.status(200).json({ status: 'success', message: 'Bookings updated successfully.', data: bookings });
    /* } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to update booking.', data: error });
    } */
};


exports.rejectBookings = async (req, res) => {
  const status = "rejected";
  const bookingsId = parseInt(req.params.id);

  try {
    const data = await Bookings.changeStatus(bookingsId, status);
    res.status(200).json({ status: 'success', message: 'Bookings rejected successfully.', data: data });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update status.', data: error });
  }
};


exports.acceptBookings = async (req, res) => {
    const status = "accepted";
    const bookingsId = parseInt(req.params.id);

    try {
        const data = await Bookings.changeStatus(bookingsId, status);
        res.status(200).json({ status: 'success', message: 'Bookings accepted successfully.', data: data });
    } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to update status.', data: error });
    }
};



// get inward bookings
exports.getInwardBookingsByUserId = async (req, res) => {
    const userId = req.user.id;
  
    try {
      const data = await Bookings.getInwardBookingsByUserId(userId);
      if(data != null){
        res.status(200).json({ status: 'success', message: 'User bookings retrieved successfully.', data: data });
      } else {
        res.status(200).json({ status: 'success', message: 'No bookings found', data: [] });
      }
      
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to retrieve bookings', data: error });
    }
};


// get outward bookings
exports.getOutwardBookingsByUserId = async (req, res) => {
    const userId = req.user.id;
  
    try {
      const data = await Bookings.getOutwardBookingsByUserId(userId);
      if(data != null){
        res.status(200).json({ status: 'success', message: 'User bookings retrieved successfully.', data: data });
      } else {
        res.status(200).json({ status: 'success', message: 'No bookings found', data: [] });
      }
      
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to retrieve bookings', data: error });
    }
};


exports.removeBookings = async (req, res) => {
  const userId = req.user.id;
  const id = parseInt(req.params.id)

  try {
    const data = await Bookings.deleteBookings(userId, id);
    res.status(200).json({ status: 'success', message: 'Bookings deleted successfully.', data: data });
  } catch (error) {
  res.status(500).json({status: 'error', message: 'Failed to delete bookings.', data: error });
  }
};

