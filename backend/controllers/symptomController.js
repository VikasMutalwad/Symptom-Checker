const { body, validationResult } = require('express-validator');
const mlService = require('../services/mlService');
const loggingService = require('../services/loggingService');
const { calculateSeverity, getFirstAidInstructions, getActionRecommendation } = require('../utils/helpers');

class SymptomController {
  // Validation rules
  get validateAnalyzeSymptoms() {
    return [
      body('age').isInt({ min: 1, max: 120 }).withMessage('Age must be between 1 and 120'),
      body('gender').isIn(['male', 'female', 'other']).withMessage('Invalid gender'),
      body('duration').isIn(['1–2 days', '3–5 days', '>5 days']).withMessage('Invalid duration'),
      body('symptoms').isArray({ min: 1 }).withMessage('At least one symptom required'),
      body('symptoms.*').isString().withMessage('Symptoms must be strings'),
      body('additional_notes').optional().isString().withMessage('Additional notes must be a string')
    ];
  }

  async analyzeSymptoms(req, res) {
    try {
      // Check validation errors
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({
          error: 'Validation failed',
          details: errors.array()
        });
      }

      const { age, gender, duration, symptoms, additional_notes } = req.body;

      // Get ML prediction
      const mlResult = await mlService.analyzeSymptoms(symptoms, additional_notes);

      // Calculate severity based on highest confidence
      const maxConfidence = Math.max(...mlResult.conditions.map(c => c.confidence));
      const severity = calculateSeverity(maxConfidence);

      // Get first aid instructions
      const first_aid = getFirstAidInstructions(severity);

      // Determine action and emergency status
      const emergency = severity === 'Severe' || mlResult.emergency === true;
      const action = getActionRecommendation(severity, emergency);

      const response = {
        conditions: mlResult.conditions,
        severity,
        first_aid,
        action,
        emergency
      };

      // Log analysis (anonymized)
      await loggingService.logAnalysis({
        age,
        gender,
        duration,
        symptoms,
        additional_notes,
        ...response
      });

      res.json(response);

    } catch (error) {
      console.error('Error in analyzeSymptoms:', error);
      res.status(500).json({
        error: 'Internal server error',
        message: 'Failed to analyze symptoms'
      });
    }
  }

  getSymptoms(req, res) {
    // Return list of available symptoms
    const symptoms = [
      'fever', 'cough', 'headache', 'chest pain', 'breathing difficulty',
      'fatigue', 'nausea', 'body pain', 'sore throat', 'runny nose'
    ];

    res.json({ symptoms });
  }

  getClinics(req, res) {
    // Mock clinic data
    const clinics = [
      {
        id: 1,
        name: 'City General Hospital',
        distance: '2.3 km',
        phone: '+1-555-0123',
        address: '123 Main St, City, State'
      },
      {
        id: 2,
        name: 'Medical Center Plus',
        distance: '3.1 km',
        phone: '+1-555-0456',
        address: '456 Health Ave, City, State'
      },
      {
        id: 3,
        name: 'Urgent Care Clinic',
        distance: '1.8 km',
        phone: '+1-555-0789',
        address: '789 Care Blvd, City, State'
      }
    ];

    res.json({ clinics });
  }

  healthCheck(req, res) {
    res.json({
      status: 'healthy',
      timestamp: new Date().toISOString(),
      version: '1.0.0'
    });
  }
}

module.exports = new SymptomController();