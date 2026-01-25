# 🏥 AI-Powered Symptom Checker & Diagnosis Assistant

An intelligent mobile application that helps users assess their symptoms, receive preliminary diagnosis suggestions, and locate nearby healthcare facilities.

## 📋 Project Structure

```
Symptom-Checker/
├── frontend/          # Flutter mobile app
├── backend/           # Express.js API server
├── ml/               # Python ML model and Flask API
└── datasets/         # Training data
```

## 🚀 Quick Start

### Prerequisites
- **Flutter** 3.0+
- **Node.js** 18+
- **Python** 3.8+
- **Android SDK** (for mobile testing)

### Installation

#### 1. Backend Setup

```bash
cd backend
npm install
```

Configure `.env`:
```env
PORT=5000
NODE_ENV=development
ML_API_URL=http://localhost:5001
CORS_ORIGIN=http://localhost:3000
```

Start backend:
```bash
npm start
```

#### 2. ML Setup

```bash
cd ml
pip install -r requirements.txt

# Train the model
python train.py

# Start ML API
python app.py
```

#### 3. Frontend Setup

```bash
cd frontend
flutter pub get

# For Android emulator
flutter emulator --launch Pixel_9_Pro
flutter run
```

## 🔧 API Endpoints

### Backend (Express - Port 5000)

#### Analyze Symptoms
```
POST /api/analyze-symptoms
Body: {
  "symptoms": ["Fever", "Cough"],
  "additionalInfo": "Optional details",
  "userDetails": {}
}
```

#### Get Available Symptoms
```
GET /api/symptoms
```

#### Get Nearby Clinics
```
GET /api/clinics
```

#### Health Check
```
GET /health
```

### ML API (Flask - Port 5001)

#### Predict Diagnosis
```
POST /predict
Body: {
  "symptoms": ["Fever", "Cough"],
  "additionalInfo": "Optional text"
}
Response: {
  "conditions": ["Common Cold"],
  "confidence": 0.72,
  "severity": "moderate"
}
```

## 🏗️ Architecture

```
┌─────────────────┐
│  Flutter App    │
│ (Android/iOS)   │
└────────┬────────┘
         │ HTTP
         ▼
┌─────────────────┐
│ Express Backend │
│  (Node.js)      │
└────────┬────────┘
         │ HTTP
         ▼
┌─────────────────┐
│  Flask ML API   │
│    (Python)     │
└─────────────────┘
```

## 📱 Features

- ✅ Symptom selection interface
- ✅ AI-powered diagnosis suggestions
- ✅ Severity assessment
- ✅ Nearby clinic locator
- ✅ First aid recommendations
- ✅ Multi-platform support (Android, iOS, Web)

## 🔄 Workflow

1. **User enters details** - Name, age, location
2. **Select symptoms** - Choose from predefined or add custom
3. **Analysis** - Backend sends to ML model for prediction
4. **Results** - Diagnosis with confidence score and severity
5. **Recommendations** - Clinics and first aid tips

## 🧠 ML Model

- **Algorithm**: Random Forest Classifier
- **Features**: Binary symptom indicators
- **Training Data**: Medical symptom-condition pairs
- **Accuracy**: ~85% on test data

### To Retrain Model:

```bash
cd ml
# Update datasets/train.csv with new data
python train.py
```

## ⚙️ Configuration

### API Endpoints

**For Android Emulator:**
```dart
static const String baseUrl = 'http://10.0.2.2:5000';
```

**For Physical Device:**
```dart
static const String baseUrl = 'http://YOUR_MACHINE_IP:5000';
```

Update IP in `frontend/lib/services/api_service.dart`

## 🧪 Testing

### Test Backend
```bash
cd backend
curl http://localhost:5000/health
curl -X GET http://localhost:5000/api/symptoms
```

### Test ML API
```bash
cd ml
curl -X POST http://localhost:5001/predict \
  -H "Content-Type: application/json" \
  -d '{"symptoms":["Fever","Cough"]}'
```

### Test Flutter App
```bash
cd frontend
flutter run --verbose
```

## 📊 Database (Future Implementation)

Current version uses mock data. Future versions will include:
- User profiles and history
- Symptom-condition mappings
- Clinic information
- Prediction feedback for model improvement

## ⚠️ Disclaimer

This application is for **educational purposes only**. It does not replace professional medical advice. Always consult a qualified healthcare provider for proper diagnosis and treatment.

## 📝 License

MIT License - See LICENSE file for details

## 👥 Contributing

Pull requests welcome! Please follow:
1. Create feature branch
2. Commit changes
3. Submit pull request

## 📧 Support

For issues and questions, please open a GitHub issue.

---

**Last Updated**: January 25, 2026
