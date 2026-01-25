const { db } = require('../firebase/config');

class LoggingService {
  async logAnalysis(data) {
    try {
      // Anonymize data - remove personal identifiers
      const anonymizedData = {
        timestamp: new Date().toISOString(),
        age: data.age,
        gender: data.gender,
        duration: data.duration,
        symptoms: data.symptoms,
        additional_notes: data.additional_notes,
        conditions: data.conditions,
        severity: data.severity,
        emergency: data.emergency
      };

      await db.collection('analysis_logs').add(anonymizedData);
      console.log('Analysis logged successfully');
    } catch (error) {
      console.error('Error logging analysis:', error);
      // Don't throw error - logging failure shouldn't break the app
    }
  }
}

module.exports = new LoggingService();