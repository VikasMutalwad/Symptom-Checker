const express = require('express');
const router = express.Router();
const symptomController = require('../controllers/symptomController');

// POST /api/analyze-symptoms
router.post('/analyze-symptoms',
  symptomController.validateAnalyzeSymptoms,
  symptomController.analyzeSymptoms.bind(symptomController)
);

// GET /api/symptoms
router.get('/symptoms', symptomController.getSymptoms.bind(symptomController));

// GET /api/clinics
router.get('/clinics', symptomController.getClinics.bind(symptomController));

// GET /health
router.get('/health', symptomController.healthCheck.bind(symptomController));

module.exports = router;