const axios = require('axios');

class MLService {
  constructor() {
    this.mlApiUrl = process.env.ML_API_URL || 'http://localhost:5000/predict';
  }

  async analyzeSymptoms(symptoms, additionalNotes) {
    try {
      const response = await axios.post(this.mlApiUrl, {
        symptoms: symptoms,
        additional_notes: additionalNotes || ''
      }, {
        timeout: 5000 // 5 second timeout
      });

      return response.data;
    } catch (error) {
      console.error('ML API Error:', error.message);
      // Return fallback prediction
      return this.getFallbackPrediction(symptoms);
    }
  }

  getFallbackPrediction(symptoms) {
    // Simple fallback logic based on symptoms
    const hasSevereSymptoms = symptoms.some(symptom =>
      ['chest pain', 'breathing difficulty', 'severe headache'].includes(symptom.toLowerCase())
    );

    if (hasSevereSymptoms) {
      return {
        conditions: [{ name: 'Potential Serious Condition', confidence: 0.8 }],
        severity: 'Severe'
      };
    }

    return {
      conditions: [{ name: 'Common Illness', confidence: 0.5 }],
      severity: 'Moderate'
    };
  }
}

module.exports = new MLService();