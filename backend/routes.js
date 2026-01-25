const express = require('express');
const axios = require('axios');
const router = express.Router();
const mlClient = require('./ml_client');
const logic = require('./logic');

// POST /api/analyze-symptoms
// Analyze user symptoms and get diagnosis recommendations
router.post('/analyze-symptoms', async (req, res) => {
  try {
    const { symptoms, additionalInfo, userDetails } = req.body;

    // Validate input
    if (!symptoms || symptoms.length === 0) {
      return res.status(400).json({
        error: true,
        message: 'At least one symptom must be provided'
      });
    }

    // Call ML model for prediction
    const diagnosis = await mlClient.predictDiagnosis(symptoms, additionalInfo);

    // Get recommended clinics
    const clinics = await logic.getRecommendedClinics(
      diagnosis.severity,
      userDetails?.location
    );

    // Get first aid recommendations
    const firstAid = await logic.getFirstAidRecommendations(diagnosis.conditions);

    res.json({
      error: false,
      data: {
        diagnosis: diagnosis,
        clinics: clinics,
        firstAid: firstAid,
        disclaimer: 'This is not a medical diagnosis. Please consult a healthcare professional.'
      }
    });

  } catch (error) {
    console.error('Error analyzing symptoms:', error);
    res.status(500).json({
      error: true,
      message: 'Failed to analyze symptoms',
      details: error.message
    });
  }
});

// GET /api/symptoms
// Get list of available symptoms
router.get('/symptoms', (req, res) => {
  try {
    const symptoms = logic.getAvailableSymptoms();
    res.json({
      error: false,
      data: symptoms
    });
  } catch (error) {
    res.status(500).json({ error: true, message: error.message });
  }
});

// GET /api/conditions
// Get list of conditions the model can diagnose
router.get('/conditions', (req, res) => {
  try {
    const conditions = logic.getAvailableConditions();
    res.json({
      error: false,
      data: conditions
    });
  } catch (error) {
    res.status(500).json({ error: true, message: error.message });
  }
});

// GET /api/clinics
// Get nearby clinics (mock data)
router.get('/clinics', (req, res) => {
  try {
    const clinics = logic.getNearbyClinics();
    res.json({
      error: false,
      data: clinics
    });
  } catch (error) {
    res.status(500).json({ error: true, message: error.message });
  }
});

// GET /api/health
// Health check
router.get('/health', (req, res) => {
  res.json({ status: 'OK', message: 'API is healthy' });
});

module.exports = router;