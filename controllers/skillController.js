const Skill = require("../models/Skill")

exports.createSkill = async (req, res) => {
    const userId = req.user.id;
    const data = req.body;
  
    try {
      const skill = await Skill.createSkill(userId, data);
      res.status(200).json({ status: 'success', message: 'Skill created successfully.', data: skill });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to create skill.' });
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
      res.status(500).json({status: 'error', message: 'Failed to update skill.' });
    }
};



exports.deleteSkill = async (req, res) => {
    const userId = req.user.id;
    const skillId = parseInt(req.params.id)   
  
    try {
      const skill = await Skill.delete(userId, skillId);
      res.status(200).json({ status: 'success', message: 'Skill deleted successfully.', data: skill });
    } catch (error) {
      res.status(500).json({status: 'error', message: 'Failed to delete skill.' });
    }
};


exports.retrievePublishedSkill = async (req, res) => {
  const status = 'published';

  try {
    const skill = await Skill.retrievePublishedSkill(status);
    res.status(200).json({ status: 'success', message: 'published skills retrieved successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills' });
  }
};


exports.searchSkillsByName = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchSkillsByName(searchTerm);
    res.status(200).json({ status: 'success', message: 'published skills retrieved successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills' });
  }
};


exports.searchSkillsByCreatorName = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchSkillsByCreatorName(searchTerm);
    res.status(200).json({ status: 'success', message: 'published skills retrieved successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills' });
  }
};


exports.searchSkillsBySparktoken = async (req, res) => {
  const searchTerm = req.params.term  

  try {
    const skill = await Skill.searchSkillsBySparktoken(searchTerm);
    res.status(200).json({ status: 'success', message: 'published skills retrieved successfully.', data: skill });
  } catch (error) {
    res.status(500).json({status: 'error', message: 'Failed to retrieve skills' });
  }
};