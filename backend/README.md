# Symptom Checker Backend

Node.js/Express backend for the AI-Powered Symptom Checker application.

## Setup

1. Install dependencies:
   ```bash
   npm install
   ```

2. Copy environment variables:
   ```bash
   cp .env.example .env
   ```

3. Add your Firebase service account key to `firebase/serviceAccountKey.json`

4. Start the server:
   ```bash
   npm run dev  # Development
   npm start    # Production
   ```

## API Endpoints

### POST /api/analyze-symptoms
Analyzes symptoms using AI/ML service.

**Request Body:**
```json
{
  "age": 25,
  "gender": "male",
  "duration": "3-5 days",
  "symptoms": ["fever", "cough"],
  "additional_notes": "mild body pain"
}
```

**Response:**
```json
{
  "conditions": [
    {
      "name": "Viral Fever",
      "confidence": 0.82
    }
  ],
  "severity": "Moderate",
  "first_aid": ["Drink plenty of fluids", "Take rest"],
  "action": "Doctor Consultation Recommended",
  "emergency": false
}
```

### GET /api/symptoms
Returns list of available symptoms.

### GET /api/clinics
Returns mock clinic data.

### GET /health
Health check endpoint.

## Deployment

This backend is configured for deployment on Render. Make sure to set environment variables in your Render dashboard.