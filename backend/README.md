<<<<<<< HEAD
# Backend API Server

Express.js REST API for the Symptom Checker application.

## Setup

```bash
npm install
npm start
```

## Environment Variables

Create `.env` file:

```env
PORT=5000
NODE_ENV=development
ML_API_URL=http://localhost:5001
ML_API_ENDPOINT=/predict
CORS_ORIGIN=*
```

## API Routes

### POST `/api/analyze-symptoms`
Analyze symptoms and get diagnosis

**Request:**
```json
{
  "symptoms": ["Fever", "Cough"],
  "additionalInfo": "Optional description",
  "userDetails": {}
=======
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
>>>>>>> vikas
}
```

**Response:**
```json
{
<<<<<<< HEAD
  "error": false,
  "data": {
    "diagnosis": {
      "conditions": ["Common Cold"],
      "confidence": 0.72,
      "severity": "moderate"
    },
    "clinics": [
      {"name": "City Hospital", "distance": "2.5 km"}
    ],
    "firstAid": {
      "Common Cold": ["Rest", "Stay hydrated"]
    }
  }
}
```

### GET `/api/symptoms`
Get available symptoms list

### GET `/api/clinics`
Get nearby clinics

### GET `/health`
Health check endpoint

## Dependencies

- **express** - Web framework
- **cors** - Cross-origin requests
- **axios** - HTTP client for ML API
- **dotenv** - Environment variables
- **body-parser** - Request body parsing

## Project Structure

```
backend/
├── server.js       # Express app setup
├── routes.js       # API endpoints
├── logic.js        # Business logic
├── ml_client.js    # ML API client
├── package.json    # Dependencies
└── .env            # Configuration
```

## Development

```bash
# Start with auto-reload
npm run dev

# Test health check
curl http://localhost:5000/health
```

## Integration with ML

The backend automatically communicates with the Flask ML API at `ML_API_URL`. If ML API is unavailable, it falls back to mock diagnosis data.
=======
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

## Docker

Build and run the backend with Docker:

```bash
docker build -t symptom-checker-backend .
docker run -p 3001:3001 \
  -e PORT=3001 \
  -e ML_API_URL=http://ml-service:5000/predict \
  -e FIREBASE_DATABASE_URL="https://<your-project>.firebaseio.com" \
  -e FIREBASE_CREDENTIALS='{"type":"..."}' \
  symptom-checker-backend
```

Recommended environment variables:
- `PORT` (default 3001)
- `ML_API_URL` (URL of ML prediction service)
- `FIREBASE_DATABASE_URL` or `FIREBASE_CREDENTIALS` (JSON string for service account)
- `FRONTEND_URL` (CORS origin)
- `NODE_ENV` (production/development)
>>>>>>> vikas
