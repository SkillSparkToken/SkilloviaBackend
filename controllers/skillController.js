const Skill = require("../models/Skill");

exports.createSkill = async (req, res) => {
  console.log("📦 Full Request Body:", req.body);
  console.log("📸 Uploaded Files:", req.files);

  // Validate request body
  if (!req.body || Object.keys(req.body).length === 0) {
    console.error("🚨 Request body is missing.");
    return res
      .status(400)
      .json({ status: "error", message: "Invalid request body." });
  }

  // Extract and trim fields
  const skill_type = req.body.skill_type ? req.body.skill_type.trim() : null;
  const experience_level = req.body.experience_level
    ? req.body.experience_level.trim()
    : null;
  const hourly_rate = req.body.hourly_rate
    ? parseFloat(req.body.hourly_rate)
    : null;
  const description = req.body.description ? req.body.description.trim() : null;

  // ✅ Extract Spark Token from request
  const spark_token = req.body.spark_token
    ? String(req.body.spark_token).trim() // Ensure it's treated as a string if needed
    : null; // Default to null if not provided
  console.log("📌 spark_token received:", req.body.spark_token);
  console.log("📌 spark_token after processing:", spark_token);

  // Check for missing fields
  if (!skill_type || !experience_level || !hourly_rate || !description) {
    console.error("🚨 Missing required fields.");
    return res
      .status(400)
      .json({ status: "error", message: "All fields are required." });
  }

  console.log("🛠️ Extracted Data:", {
    skill_type,
    experience_level,
    hourly_rate,
    spark_token, // ✅ Added Spark Token
    description,
  });

  // Extract file paths from uploaded thumbnails
  const filePaths = req.files?.thumbnails
    ? req.files.thumbnails.map((file) => file.location).slice(0, 4)
    : [];

  console.log("📂 Extracted File Paths:", filePaths);

  // Define user ID and data object
  const userId = req.user.id;
  const data = {
    skill_type,
    experience_level,
    hourly_rate,
    spark_token, // ✅ Save Spark Token
    description,
    thumbnails: {
      thumbnail01: filePaths[0] || null,
      thumbnail02: filePaths[1] || null,
      thumbnail03: filePaths[2] || null,
      thumbnail04: filePaths[3] || null,
    },
  };

  console.log("🚀 Data Before Saving:", { userId, ...data });

  // Check if spark_token is numeric and parse it correctly
  const finalSparkToken = spark_token ? parseInt(spark_token, 10) : null;

  // Log the final value of finalSparkToken before inserting into the database
  console.log("📌 Final spark_token before inserting:", finalSparkToken);

  try {
    // Create skill in database
    const skill = await Skill.createSkill(userId, {
      ...data,
      spark_token: finalSparkToken, // Pass the correctly parsed finalSparkToken
    });

    console.log("✅ Skill Created Successfully:", skill);

    return res.status(201).json({
      status: "success",
      message: "Skill created successfully.",
      data: skill,
    });
  } catch (error) {
    console.error("❌ Database Error:", error);
    return res.status(500).json({
      status: "error",
      message: "Failed to create skill.",
      error: error.message,
    });
  }
};

exports.updateSkill = async (req, res) => {
  const userId = req.user.id;
  const skillId = parseInt(req.params.id);
  const updates = req.body;

  const checkskill = await Skill.findSkill(skillId, userId);
  if (checkskill == null) {
    return res.status(400).send({
      status: "error",
      message: "No skill found",
      data: null,
    });
  }

  // Ensure filePaths is populated with up to 4 uploaded files
  const filePaths = req.files.map((file) => file.path).slice(0, 4);
  const thumbnail01 = filePaths[0] ? filePaths[0].slice(15) : null;
  const thumbnail02 = filePaths[1] ? filePaths[1].slice(15) : null;
  const thumbnail03 = filePaths[2] ? filePaths[2].slice(15) : null;
  const thumbnail04 = filePaths[3] ? filePaths[3].slice(15) : null;

  // Assign file paths to respective columns
  updates.thumbnails = {
    thumbnail01: thumbnail01 || null,
    thumbnail02: thumbnail02 || null,
    thumbnail03: thumbnail03 || null,
    thumbnail04: thumbnail04 || null,
  };

  try {
    const skill = await Skill.update(userId, skillId, updates);
    res.status(200).json({
      status: "success",
      message: "Skill updated successfully.",
      data: skill,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to update skill.",
      data: error,
    });
  }
};

exports.updatePublishedStatus = async (req, res) => {
  const skillId = parseInt(req.params.id);
  const status = "published";

  try {
    const skill = await Skill.updatePublishedStatus(skillId, status);
    res.status(200).json({
      status: "success",
      message: "Skill published successfully.",
      data: skill,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to update skill.",
      data: error,
    });
  }
};

exports.deleteSkill = async (req, res) => {
  const userId = req.user.id;
  const skillId = parseInt(req.params.id);

  try {
    const skill = await Skill.delete(userId, skillId);
    res.status(200).json({
      status: "success",
      message: "Skill deleted successfully.",
      data: skill,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to delete skill.",
      data: error,
    });
  }
};

exports.retrievePublishedSkill = async (req, res) => {
  const status = "published";

  try {
    const skill = await Skill.retrievePublishedSkill(status);
    if (skill != null) {
      res.status(200).json({
        status: "success",
        message: "published skills retrieved successfully.",
        data: skill,
      });
    } else {
      res.status(200).json({
        status: "success",
        message: "No published record found",
        data: null,
      });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error,
    });
  }
};

// exports.retrieveUserSkill = async (req, res) => {
//   const status = "published";
//   const userId = req.user.id;

//   try {
//     const skill = await Skill.retrieveUserSkill(userId);
//     if (skill != null) {
//       res.status(200).json({
//         status: "success",
//         message: "skills retrieved successfully.",
//         data: skill,
//       });
//     } else {
//       res
//         .status(200)
//         .json({ status: "success", message: "No record found", data: null });
//     }
//   } catch (error) {
//     res.status(500).json({
//       status: "error",
//       message: "Failed to retrieve skills",
//       data: error,
//     });
//   }
// };
exports.retrieveUserSkill = async (req, res) => {
  const userId = req.user.id;

  try {
    const skill = await Skill.retrieveUserSkills(userId); // FIXED here
    if (skill != null) {
      res.status(200).json({
        status: "success",
        message: "skills retrieved successfully.",
        data: skill,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No record found", data: null });
    }
  } catch (error) {
    console.error("Error retrieving skills:", error); // Add for debugging
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error.message, // send only message for safety
    });
  }
};

exports.searchSkillsByName = async (req, res) => {
  const searchTerm = req.params.term;

  try {
    const skill = await Skill.searchSkillsByName(searchTerm);
    if (skill && skill.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Search result retrieved successfully.",
        data: skill,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No record found", data: null });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error,
    });
  }
};

exports.searchUsersBySkillType = async (req, res) => {
  const searchTerm = req.params.term;

  try {
    const skill = await Skill.searchUsersBySkillType(searchTerm);
    if (skill && skill.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Search result retrieved successfully.",
        data: skill,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No record found", data: null });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error,
    });
  }
};

exports.searchSkillsByCreatorName = async (req, res) => {
  const searchTerm = req.params.term;

  try {
    const skill = await Skill.searchSkillsByCreatorName(searchTerm);
    if (skill && skill.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Search result retrieved successfully.",
        data: skill,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No record found", data: null });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error,
    });
  }
};

exports.searchSkillsBySparktoken = async (req, res) => {
  const searchTerm = req.params.term;

  try {
    const skill = await Skill.searchSkillsBySparktoken(searchTerm);
    if (skill && skill.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Search result retrieved successfully.",
        data: skill,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No record found", data: null });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error,
    });
  }
};

exports.deleteSkillPhoto = async (req, res) => {
  const userId = req.user.id;
  const skillId = parseInt(req.params.id);
  const { key } = req.body;

  try {
    const checkskill = await Skill.findSkill(skillId, userId);
    if (checkskill == null) {
      return res.status(400).send({
        status: "error",
        message: "No skill found",
        data: null,
      });
    }

    const skill = await Skill.deletePhoto(key, userId, skillId);
    res.status(200).json({
      status: "success",
      message: "Skill photo deleted successfully.",
      data: skill,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to delete skill photo.",
      data: error,
    });
  }
};

exports.searchSkillsByType = async (req, res) => {
  const searchTerm = req.params.term;

  try {
    const skill = await Skill.searchSkillsByType(searchTerm);

    if (skill && skill.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Search result retrieved successfully.",
        data: skill,
      });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "No record found", data: null });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error,
    });
  }
};

// // get skill category
// exports.getSkillCategory = async (req, res) => {
//   const status = "published";

//   try {
//     const data = await Skill.getSkillCategory(status);
//     if (data != null) {
//       res.status(200).json({
//         status: "success",
//         message: "skills retrieved successfully.",
//         data: data,
//       });
//     } else {
//       res
//         .status(200)
//         .json({ status: "success", message: "No skill found", data: null });
//     }
//   } catch (error) {
//     res.status(500).json({
//       status: "error",
//       message: "Failed to retrieve skills",
//       data: error,
//     });
//   }
// };
// get all skill categories (both published and unpublished)
exports.getSkillCategory = async (req, res) => {
  try {
    // Assuming getSkillCategory without any filter fetches all skills
    const data = await Skill.getSkillCategory();

    if (data && data.length > 0) {
      res.status(200).json({
        status: "success",
        message: "Skills retrieved successfully.",
        data: data,
      });
    } else {
      res.status(200).json({
        status: "success",
        message: "No skills found",
        data: null,
      });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Failed to retrieve skills",
      data: error.message || error,
    });
  }
};
