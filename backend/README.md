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
}
```

**Response:**
```json
{
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
