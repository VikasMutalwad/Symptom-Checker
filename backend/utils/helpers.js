function calculateSeverity(confidence) {
  if (confidence < 0.4) return 'Mild';
  if (confidence <= 0.7) return 'Moderate';
  return 'Severe';
}

function getFirstAidInstructions(severity) {
  const instructions = {
    Mild: [
      'Rest and stay hydrated',
      'Take over-the-counter pain relievers if needed',
      'Monitor symptoms closely',
      'Contact healthcare provider if symptoms worsen'
    ],
    Moderate: [
      'Rest and drink plenty of fluids',
      'Take prescribed medications as directed',
      'Monitor temperature and symptoms',
      'Seek medical attention if symptoms persist beyond 3-5 days'
    ],
    Severe: [
      'Seek immediate medical attention',
      'Call emergency services if experiencing severe symptoms',
      'Do not delay professional medical care',
      'Follow emergency response protocols'
    ]
  };

  return instructions[severity] || instructions.Moderate;
}

function getActionRecommendation(severity, emergency = false) {
  if (emergency) return 'Emergency Care Required';
  if (severity === 'Severe') return 'Urgent Medical Consultation Required';
  if (severity === 'Moderate') return 'Doctor Consultation Recommended';
  return 'Home Care with Monitoring';
}

module.exports = {
  calculateSeverity,
  getFirstAidInstructions,
  getActionRecommendation
};