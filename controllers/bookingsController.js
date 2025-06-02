const Bookings = require("../models/Bookings");

// exports.createBookings = async (req, res) => {
//   const userId = req.user.id;
//   const data = req.body;

//   if(req.body.title != null){
//     let file = null

//     if(req.filePaths != null){
//         const filePath = req.filePaths;
//         file = filePath.slice(15);
//     }

//     try {
//         const bookings = await Bookings.create(userId, data, file);
//         res.status(200).json({ status: 'success', message: 'Skill booked successfully.', data: bookings });
//     } catch (error) {
//         res.status(500).json({status: 'error', message: 'Failed to book skills.', data: error });
//     }

//   } else {
//     res.status(400).send({
//         status: 'error',
//         message: 'Title is required',
//         data: null
//     });
//   }
// };
exports.createBookings = async (req, res) => {
  const userId = req.user.id;
  const data = req.body;
  // data.status = data.status || "pending"; // This will default to 'pending' if no status is provided

  if (!data.title) {
    return res.status(400).json({
      status: "error",
      message: "Title is required",
      data: null,
    });
  }

  let fileUrl = null;
  if (req.file) {
    fileUrl = req.file.location; // AWS S3 returns the file URL in `req.file.location`
  }

  // Extract file paths from uploaded thumbnails
  const filePaths = req.files?.thumbnails
    ? req.files.thumbnails.map((file) => file.location).slice(0, 4)
    : [];

  console.log("📂 Extracted File Paths:", filePaths);

  const {
    skills_id,
    booked_user_id,
    title,
    description,
    booking_location,
    booking_date,
  } = data;


  const formatedData = {
    skills_id,
    booked_user_id,
    title,
    spark_token, 
    description,
    booking_location,
    booking_date,
    thumbnails: {
      thumbnail01: filePaths[0] || null,
      thumbnail02: filePaths[1] || null,
      thumbnail03: filePaths[2] || null,
      thumbnail04: filePaths[3] || null,
    },
  };

  try {
    const bookings = await Bookings.create(userId, formatedData);
    res.status(200).json({
      status: "success",
      message: "Skill booked successfully.",
      data: bookings,
    });
  } catch (error) {
    console.error("Error in createBookings:", error);
    res.status(500).json({
      status: "error",
      message: "Failed to book skills.",
      data: error,
    });
  }
};

exports.updateBookings = async (req, res) => {
  const bookingsId = parseInt(req.params.id);
  const data = req.body;

  let file = null;
  if (req.filePaths != null) {
    const filePath = req.filePaths;
    file = filePath.slice(15);
  }

  //try {
  const bookings = await Bookings.update(bookingsId, data, file);
  res.status(200).json({
    status: "success",
    message: "Bookings updated successfully.",
    data: bookings,
  });
  /* } catch (error) {
        res.status(500).json({status: 'error', message: 'Failed to update booking.', data: error });
    } */
};

exports.rejectBookings = async (req, res) => {
  const status = "rejected";
  const bookingsId = parseInt(req.params.id);

  try {
    const data = await Bookings.changeStatus(bookingsId, status);
    res.status(200).json({
      status: "success",
      message: "Bookings rejected successfully.",
      data: data,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to update status.",
      data: error,
    });
  }
};

exports.acceptBookings = async (req, res) => {
  const status = "accepted";
  const bookingsId = parseInt(req.params.id);

  try {
    const data = await Bookings.changeStatus(bookingsId, status);
    res.status(200).json({
      status: "success",
      message: "Bookings accepted successfully.",
      data: data,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to update status.",
      data: error,
    });
  }
};

// exports.startBooking = async (req, res) => {
//   const status = "in-progress";
//   const bookingId = parseInt(req.params.id);

//   try {
//     const data = await Bookings.changeStatus(bookingId, status);
//     res.status(200).json({
//       status: "success",
//       message: "Booking started successfully.",
//       data: data,
//     });
//   } catch (error) {
//     res.status(500).json({
//       status: "error",
//       message: "Failed to start booking.",
//       data: error,
//     });
//   }
// };

exports.startBooking = async (req, res) => {
  const status = "in-progress";
  const bookingId = parseInt(req.params.id); // Only using the ID from the URL

  try {
    const data = await Bookings.changeStatus(bookingId, status);
    res.status(200).json({
      status: "success",
      message: "Booking started successfully.",
      data: data,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to start booking.",
      data: error,
    });
  }
};

// exports.completeBooking = async (req, res) => {
//   const status = "completed";
//   const bookingId = parseInt(req.params.id);

//   try {
//     const data = await Bookings.changeStatus(bookingId, status);
//     res.status(200).json({
//       status: "success",
//       message: "Booking completed successfully.",
//       data: data,
//     });
//   } catch (error) {
//     res.status(500).json({
//       status: "error",
//       message: "Failed to complete booking.",
//       data: error,
//     });
//   }
// };

// get inward bookings

exports.completeBooking = async (req, res) => {
  const status = req.body.status || "completed"; // Default to "completed" if not passed
  const bookingId = parseInt(req.params.id);

  try {
    const data = await Bookings.changeStatus(bookingId, status);
    res.status(200).json({
      status: "success",
      message: "Booking completed successfully.",
      data: data,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to complete booking.",
      data: error,
    });
  }
};

exports.getInwardBookingsByUserId = async (req, res) => {
  const userId = req.user.id;

  try {
    const data = await Bookings.getInwardBookingsByUserId(userId);
    if (data != null) {
      res.status(200).json({
        status: "success",
        message: "User bookings retrieved successfully.",
        data: data,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No bookings found", data: [] });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve bookings",
      data: error,
    });
  }
};

// get outward bookings
exports.getOutwardBookingsByUserId = async (req, res) => {
  const userId = req.user.id;

  try {
    const data = await Bookings.getOutwardBookingsByUserId(userId);
    if (data != null) {
      res.status(200).json({
        status: "success",
        message: "User bookings retrieved successfully.",
        data: data,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No bookings found", data: [] });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve bookings",
      data: error,
    });
  }
};

exports.removeBookings = async (req, res) => {
  const userId = req.user.id;
  const id = parseInt(req.params.id);

  try {
    const data = await Bookings.deleteBookings(userId, id);
    res.status(200).json({
      status: "success",
      message: "Bookings deleted successfully.",
      data: data,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to delete bookings.",
      data: error,
    });
  }
};
