const axios = require('axios');

const ML_API_URL = process.env.ML_API_URL || 'http://localhost:5001';
const ML_API_ENDPOINT = process.env.ML_API_ENDPOINT || '/predict';

// Mock diagnosis data for fallback
const MOCK_DIAGNOSES = {
  'Chest Pain,Breathing Difficulty': {
    conditions: ['Possible Heart Condition', 'Respiratory Issue'],
    confidence: 0.85,
    severity: 'severe'
  },
  'Fever,Cough': {
    conditions: ['Common Cold', 'Flu', 'COVID-19'],
    confidence: 0.72,
    severity: 'moderate'
  },
  'Fever': {
    conditions: ['Common Cold', 'Flu'],
    confidence: 0.65,
    severity: 'mild'
  }
};

async function predictDiagnosis(symptoms, additionalInfo) {
  try {
    // Try to call ML API
    const response = await axios.post(
      `${ML_API_URL}${ML_API_ENDPOINT}`,
      { symptoms, additionalInfo },
      { timeout: 5000 }
    );

    return {
      conditions: response.data.conditions || [],
      confidence: response.data.confidence || 0,
      severity: response.data.severity || 'mild'
    };

  } catch (error) {
    console.warn('ML API unavailable, using mock diagnosis');
    return getMockDiagnosis(symptoms);
  }
}

function getMockDiagnosis(symptoms) {
  // Create key from symptoms
  const key = symptoms.join(',');
  
  // Check if exact match exists
  if (MOCK_DIAGNOSES[key]) {
    return MOCK_DIAGNOSES[key];
  }

  // Check for partial matches
  for (const diagKey in MOCK_DIAGNOSES) {
    const diagSymptoms = diagKey.split(',');
    if (diagSymptoms.some(s => symptoms.includes(s))) {
      return MOCK_DIAGNOSES[diagKey];
    }
  }

  // Default diagnosis
  return {
    conditions: ['General Illness - Please consult a healthcare professional'],
    confidence: 0.5,
    severity: 'mild'
  };
}

module.exports = {
  predictDiagnosis,
  getMockDiagnosis
};