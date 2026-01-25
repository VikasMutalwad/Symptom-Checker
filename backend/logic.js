// Business logic for symptom checker

const AVAILABLE_SYMPTOMS = [
  'Fever',
  'Cough',
  'Headache',
  'Chest Pain',
  'Breathing Difficulty',
  'Fatigue',
  'Nausea',
  'Sore Throat',
  'Diarrhea',
  'Muscle Pain',
  'Shortness of Breath',
  'Loss of Appetite'
];

const AVAILABLE_CONDITIONS = [
  'Common Cold',
  'Flu',
  'COVID-19',
  'Bronchitis',
  'Pneumonia',
  'Heart Condition',
  'Migraine',
  'Gastroenteritis',
  'Allergy',
  'Asthma'
];

const NEARBY_CLINICS = [
  { id: 1, name: 'City General Hospital', distance: '2.5 km', rating: 4.8 },
  { id: 2, name: 'Downtown Clinic', distance: '1.8 km', rating: 4.6 },
  { id: 3, name: 'Health First Medical Center', distance: '3.2 km', rating: 4.7 },
  { id: 4, name: 'Emergency Care Center', distance: '4.1 km', rating: 4.5 },
];

const FIRST_AID_TIPS = {
  'Common Cold': [
    'Rest and get plenty of sleep',
    'Stay hydrated - drink water, warm tea, and soup',
    'Use a humidifier to ease congestion',
    'Gargle with salt water for sore throat',
    'Seek medical help if symptoms worsen'
  ],
  'Flu': [
    'Rest immediately',
    'Stay hydrated',
    'Take over-the-counter pain relievers',
    'Isolate from others to prevent spread',
    'Contact doctor for antiviral medication'
  ],
  'Heart Condition': [
    'Call emergency services immediately',
    'Chew aspirin if recommended by doctor',
    'Remain calm and avoid strenuous activity',
    'Seek immediate medical attention',
    'Do not delay medical care'
  ]
};

function getAvailableSymptoms() {
  return AVAILABLE_SYMPTOMS;
}

function getAvailableConditions() {
  return AVAILABLE_CONDITIONS;
}

function getNearbyClinics() {
  return NEARBY_CLINICS;
}

function getRecommendedClinics(severity, location) {
  // For now, return top clinics based on severity
  if (severity === 'severe') {
    return NEARBY_CLINICS.slice(0, 2); // Top 2 for severe cases
  } else if (severity === 'moderate') {
    return NEARBY_CLINICS.slice(0, 3); // Top 3 for moderate cases
  }
  return NEARBY_CLINICS; // All for mild cases
}

function getFirstAidRecommendations(conditions) {
  const tips = {};
  conditions.forEach(condition => {
    if (FIRST_AID_TIPS[condition]) {
      tips[condition] = FIRST_AID_TIPS[condition];
    }
  });
  return tips;
}

module.exports = {
  getAvailableSymptoms,
  getAvailableConditions,
  getNearbyClinics,
  getRecommendedClinics,
  getFirstAidRecommendations
};