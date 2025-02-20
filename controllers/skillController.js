const Skill = require("../models/Skill")

exports.createSkill = async (req, res) => {
  const userId = req.user.id;
  const data = req.body;

  // Ensure filePaths is populated with up to 4 uploaded files
  const filePaths = req.files.map(file => file.path).slice(0, 4);
  const thumbnail01 = filePaths[0] ? filePaths[0].slice(15) : null;
  const thumbnail02 = filePaths[1] ? filePaths[1].slice(15) : null;
  const thumbnail03 = filePaths[2] ? filePaths[2].slice(15) : null;
  const thumbnail04 = filePaths[3] ? filePaths[3].slice(15) : null;

  // Assign file paths to respective columns
  data.thumbnails = {
    thumbnail01: thumbnail01 || null,
    thumbnail02: thumbnail02 || null,
    thumbnail03: thumbnail03 || null,
    thumbnail04: thumbnail04 || null,
  };

  try {
    const skill = await Skill.create(userId, data);
    res.status(200).json({ 
      status: 'success', 
      message: 'Skill created successfully.', 
      data: skill 
    });
  } catch (error) {
    res.status(500).json({ 
      status: 'error', 
      message: 'Failed to create skill.', 
      data: error 
    });
  }
};



exports.updateSkill = async (req, res) => {
  const userId = req.user.id;
  const skillId = parseInt(req.params.id);
  const updates = req.body;

  const checkskill = await Skill.findSkill(skillId, userId);
  if(checkskill == null){
    return res.status(400).send({
      status: 'error',
      message: 'No skill found',
      data: null,
    });
  }


  // Ensure filePaths is populated with up to 4 uploaded files
  const filePaths = req.files.map(file => file.path).slice(0, 4);
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
      status: 'success',
      message: 'Skill updated successfully.',
      data: skill,
    });
  } catch (error) {
    res.status(500).json({
      status: 'error',
      message: 'Failed to update skill.',
      data: error,
    });
  }
};



exports.updatePublishedStatus = async (req, res) => {
  const skillId = parseInt(req.params.id) 
  const status = 'published';

  try {
    const skill = await Skill.updatePublishedStatus(skillId, status);
    res.status(200).json({ status: 'success', message: 'Skill published successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to update skill.', data: error  });
  }
};



exports.deleteSkill = async (req, res) => {
    const userId = req.user.id;
    const skillId = parseInt(req.params.id)   
  
    try {
      const skill = await Skill.delete(userId, skillId);
      res.status(200).json({ status: 'success', message: 'Skill deleted successfully.', data: skill });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to delete skill.', data: error });
    }
};


exports.retrievePublishedSkill = async (req, res) => {
  const status = 'published';

  try {
    const skill = await Skill.retrievePublishedSkill(status);
    if(skill != null){
      res.status(200).json({ status: 'success', message: 'published skills retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No published record found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};



exports.retrieveUserSkill = async (req, res) => {
  const status = 'published';
  const userId = req.user.id;

  try {
    const skill = await Skill.retrieveUserSkill(userId);
    if(skill != null){
      res.status(200).json({ status: 'success', message: 'skills retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No record found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};


exports.searchSkillsByName = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchSkillsByName(searchTerm);
    if(skill && skill.length > 0){
      res.status(200).json({ status: 'success', message: 'Search result retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No record found', data: null });
    }
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};


exports.searchUsersBySkillType = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchUsersBySkillType(searchTerm);
    if(skill && skill.length > 0){
      res.status(200).json({ status: 'success', message: 'Search result retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No record found', data: null });
    }
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};



exports.searchSkillsByCreatorName = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchSkillsByCreatorName(searchTerm);
    if(skill && skill.length > 0){
      res.status(200).json({ status: 'success', message: 'Search result retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No record found', data: null });
    }
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};


exports.searchSkillsBySparktoken = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchSkillsBySparktoken(searchTerm);
    if(skill && skill.length > 0){
      res.status(200).json({ status: 'success', message: 'Search result retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No record found', data: null });
    }
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};


exports.deleteSkillPhoto = async (req, res) => {
  const userId = req.user.id;
  const skillId = parseInt(req.params.id) 
  const { key } = req.body;  

  try {
    const checkskill = await Skill.findSkill(skillId, userId);
    if(checkskill == null){
      return res.status(400).send({
        status: 'error',
        message: 'No skill found',
        data: null,
      });
    }
    
    const skill = await Skill.deletePhoto(key, userId, skillId);
    res.status(200).json({ status: 'success', message: 'Skill photo deleted successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to delete skill photo.', data: error });
  }
};


exports.searchSkillsByType = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchSkillsByType(searchTerm);
    
    if(skill && skill.length > 0){
      res.status(200).json({ status: 'success', message: 'Search result retrieved successfully.', data: skill });
    } else {
      res.status(200).json({ status: 'success', message: 'No record found', data: null });
    }
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};


// get skill category
exports.getSkillCategory = async (req, res) => {
  const status = 'published';

  try {
    const data = await Skill.getSkillCategory(status);
    if(data != null){
      res.status(200).json({ status: 'success', message: 'skills retrieved successfully.', data: data });
    } else {
      res.status(200).json({ status: 'success', message: 'No skill found', data: null });
    }
    
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills', data: error });
  }
};
