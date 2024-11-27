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