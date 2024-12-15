const Skill = require("../models/Skill")

exports.createSkill = async (req, res) => {
    const userId = req.user.id;
    const data = req.body;

    try {
      const skill = await Skill.create(userId, data);
      res.status(200).json({ status: 'success', message: 'Skill created successfully.', data: skill });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to create skill.', data: error });
    }
};


exports.updateSkill = async (req, res) => {
    const userId = req.user.id;
    const updates = req.body;
    const skillId = parseInt(req.params.id) 
  
    try {
      const skill = await Skill.update(userId, skillId, updates);
      res.status(200).json({ status: 'success', message: 'Skill updated successfully.', data: skill });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to update skill.', data: error  });
    }
};


exports.updatePublishedStatus = async (req, res) => {
  const userId = req.user.id;
  const skillId = parseInt(req.params.id) 
  const status = 'published';

  try {
    const skill = await Skill.updatePublishedStatus(userId, skillId, status);
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
