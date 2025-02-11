const Admin = require("../models/Admin")


/* ---------------   SKILLS  ------------------- */
/* ---------------  CONTROLLERS  ----------------- */

exports.publishSkill = async (req, res) => {
  const skillId = parseInt(req.params.id) 
  const status = 'published';

  try {
    const skill = await Admin.publishSkill(skillId, status);
    res.status(200).json({ status: 'success', message: 'Skill published successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update skill.', data: error  });
  }
};


exports.unPublishSkill = async (req, res) => {
  const skillId = parseInt(req.params.id) 
  const status = 'draft';

  try {
    const skill = await Admin.unPublishSkill(skillId, status);
    res.status(200).json({ status: 'success', message: 'Skill unpublished successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update skill.', data: error  });
  }
};



exports.deleteSkill = async (req, res) => {
    const skillId = parseInt(req.params.id)   
  
    try {
      const skill = await Admin.deleteSkill(skillId);
      res.status(200).json({ status: 'success', message: 'Skill deleted successfully.', data: skill });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to delete skill.', data: error });
    }
};


exports.retrievePublishedSkill = async (req, res) => {
  const status = 'published';

  try {
    const skill = await Admin.retrieveSkillByStatus(status);
    if(skill != null){
      res.status(200).json({ status: 'success', message: 'published skills retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No published skill record found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};



exports.retrieveUnpublishedSkill = async (req, res) => {
  const status = 'draft';

  try {
    const skill = await Admin.retrieveSkillByStatus(status);
    if(skill != null){
      res.status(200).json({ status: 'success', message: 'draft skills retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No skill record found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};



exports.retrieveUserSkills = async (req, res) => {
  const userId = parseInt(req.params.id) 

  try {
    const skill = await Admin.retrieveUserSkills(userId);
    if(skill != null){
      res.status(200).json({ status: 'success', message: 'skills retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No record found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};


/* ---------------   USER  ------------------- */
/* ---------------  CONTROLLERS  ----------------- */


exports.registerUser = async (req, res) => {
  try {
    const check = await Admin.checkUserExist(req.body.phone, req.body.email);
    if(check == null){
      const user = await Admin.createUser(req.body);
      res.status(201).json({ status: 'success', message: 'User registered successfully.', data: user });
    
    } else {
      res.status(400).json({ status: 'error', message: 'User with same email or phone number already exist.', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Registration failed.', data: error.detail });
  }
};


exports.updateUser = async (req, res) => {
  const userId = parseInt(req.params.id);
  const updates = req.body;

  try {
    const updatedUser = await Admin.updateUser(userId, updates);
    res.status(200).json({ status: 'success', message: 'User updated successfully.', data: updatedUser });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update user.' });
  }
};


exports.getAllusers = async (req, res) => {
  try {
    const users = await Admin.getAllusers();
    if(users && users.length > 0){
      res.status(200).json({ status: 'success', message: 'users retrieved successful', data: users });
    } else{
      res.status(200).json({ status: 'success', message: 'No user found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({ message: 'Error fetching users', error: error.message });
  }
};


exports.changeUserRole = async (req, res) => {
  const userId = parseInt(req.params.user_id);
  const { roleId } = req.body;

  try {
    const updatedUser = await Admin.changeUserRole(userId, roleId);
    res.status(200).json({ status: 'success', message: 'User role updated successfully.', data: updatedUser });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update user role.' });
  }
};


/* ---------------   KYC  ------------------- */
/* ---------------  CONTROLLERS  ----------------- */


exports.approveKycStatus = async (req, res) => {
  const id = parseInt(req.params.id);
  const status = 'approved';

  try {
    const data = await Admin.changeStatus(id, status);
    res.status(200).json({ status: 'success', message: 'Kyc status updated successfully.', data: data });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update status.', data: error });
  }
};


exports.rejectKycStatus = async (req, res) => {
  const id = parseInt(req.params.id);
  const status = 'rejected';

  try {
    const data = await Admin.changeStatus(id, status);
    res.status(200).json({ status: 'success', message: 'Kyc status updated successfully.', data: data });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update status.', data: error });
  }
};


exports.retrieveUserKyc = async (req, res) => {
  const userId = parseInt(req.params.user_id);
  
  try {
    const data = await Admin.getKycByUserId(userId);
    if(data != null){
      res.status(200).json({ status: 'success', message: 'kyc documents retrieved successfully.', data: data });
    } else {
      res.status(200).json({ status: 'success', message: 'No kyc document found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve kyc documents', data: error });
  }
};


// get pending kyc
exports.retrievePendingKyc = async (req, res) => {
    const status = 'pending';
  
    try {
      const data = await Admin.getKycs(status);
      if(data != null){
        res.status(200).json({ status: 'success', message: 'kyc documents retrieved successfully.', data: data });
      } else {
        res.status(200).json({ status: 'success', message: 'No pending kyc document found', data: null });
      }
      
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to retrieve kyc documents', data: error });
    }
};


// get approved kyc
exports.retrieveApprovedKyc = async (req, res) => {
    const status = 'approved';
  
    try {
      const data = await Admin.getKycs(status);
      if(data != null){
        res.status(200).json({ status: 'success', message: 'kyc documents retrieved successfully.', data: data });
      } else {
        res.status(200).json({ status: 'success', message: 'No pending kyc document found', data: null });
      }
      
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to retrieve kyc documents', data: error });
    }
};


exports.removeKyc = async (req, res) => {
  const id = parseInt(req.params.id)

  try {
    const data = await Admin.deleteKyc(id);
    res.status(200).json({ status: 'success', message: 'KYC document removed successfully.', data: data });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to remove KYC document.', data: error });
  }
};


exports.getProfileByUserId = async (req, res) => {
  const userId = parseInt(req.params.id);

  try {
    const data = await Admin.getProfileByUserId(userId);

    if (data.length === 0) {
      return res.status(404).json({ status: 'error', message: 'User profile not found.', data: data });
    }

    const { id, phone, email, firstname, lastname, gender, notification_type, appearance_mode, photourl, bio, spark_token_balance, cash_balance, total_followers, total_following, location, street, zip_code, created_at, updated_at} = data[0];

    // Map skills to an array
    const skills = data[0].skills.map((item) => ({
      description: item.description,
      skill_type: item.skill_type,
      experience_level: item.experience_level,
      hourly_rate: item.hourly_rate,
      thumbnail01: item.thumbnail01,
      thumbnail02: item.thumbnail02,
      thumbnail03: item.thumbnail03,
      thumbnail04: item.thumbnail04
    }));

     // Map kyc to an array
     const kyc = data[0].kyc.map((item) => ({
      kyc_method: item.kyc_method,
      kyc_id_type: item.kyc_id_type,
      document_url: item.document_url,
      approval_status: item.approval_status,
      uploaded_date: item.uploaded_date
    }));

    const userProfile = {
      id,
      phone,
      email,
      firstname,
      lastname,
      gender,
      notification_type,
      appearance_mode,
      photourl,
      bio,
      spark_token_balance, 
      cash_balance, 
      total_followers, 
      total_following,
      location, 
      street, 
      zip_code,
      created_at,
      updated_at,
      skills:skills,
      kyc:kyc
    };

    res.status(200).json({ status: 'success', message: 'User profile retrieved successfully.', data: userProfile });
  } catch (error) {
    res.status(500).json({ status: 'error', message: 'Failed to retrieve profile.' });
  }
};


// add skill category
exports.addSkillCategory = async (req, res) => {
  const data = req.body;

  if(req.filePaths != null){
    const filePath = req.filePaths;
    const thumbnail = filePath.slice(15);

    try {
      const skill = await Admin.addSkillCategory(data, thumbnail);
      res.status(200).json({ 
        status: 'success', 
        message: 'Skill category created successfully.', 
        data: skill 
      });
    } catch (error) {
      res.status(500).json({ 
        status: 'error', 
        message: 'Failed to create skill.', 
        data: error 
      });
    }
  } else {
    res.status(400).send({
        status: 'error',
        message: 'No image found',
        data: null
    });
  }
};


// get skill category
exports.getSkillCategory = async (req, res) => {
  const status = 'published';

  try {
    const data = await Admin.getSkillCategory(status);
    if(data != null){
      res.status(200).json({ status: 'success', message: 'skills retrieved successfully.', data: data });
    } else {
      res.status(200).json({ status: 'success', message: 'No skill found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};
