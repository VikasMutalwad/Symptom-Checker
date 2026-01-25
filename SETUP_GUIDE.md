# Complete Setup & Running Guide

## 📋 Prerequisites

Install before starting:

1. **Node.js** (v18+)
   - Download: https://nodejs.org/
   - Verify: `node --version` & `npm --version`

2. **Python** (v3.8+)
   - Download: https://www.python.org/
   - Verify: `python --version`

3. **Flutter** (v3.0+)
   - Guide: https://flutter.dev/docs/get-started/install
   - Verify: `flutter --version`

4. **Android SDK** (for mobile testing)
   - Included with Android Studio
   - Verify: `adb devices`

## 🚀 Step-by-Step Setup

### Step 1: Clone & Navigate

```bash
cd d:\SYMPTOM\Symptom-Checker
```

### Step 2: Backend Setup (Terminal 1)

```bash
cd backend
npm install
```

Expected output:
```
added XX packages in Xs
```

Start backend:
```bash
npm start
```

Expected output:
```
✓ Backend server running on http://localhost:5000
✓ ML API: http://localhost:5001
✓ Environment: development
```

### Step 3: ML Setup (Terminal 2)

```bash
cd ml
pip install -r requirements.txt
```

Train the model:
```bash
python train.py
```

Expected output:
```
✓ Found 12 unique symptoms
✓ Found 8 unique conditions
Training accuracy: 0.8125
Testing accuracy: 0.7500
✓ Model saved successfully
```

Start ML API:
```bash
python app.py
```

Expected output:
```
✓ Listening on http://localhost:5001
 * Running on http://0.0.0.0:5001
```

### Step 4: Frontend Setup (Terminal 3)

```bash
cd frontend
flutter pub get
```

Expected output:
```
Running "flutter pub get" in frontend...
Got dependencies
```

### Step 5: Run Emulator

```bash
# List available emulators
flutter emulators

# Launch emulator
flutter emulator --launch Pixel_9_Pro
```

Wait for emulator to fully boot (~30 seconds)

### Step 6: Run Flutter App

```bash
cd frontend
flutter run
```

Expected output:
```
✓ Built build\app\outputs\flutter-apk\app-debug.apk
✓ Installing APK on device
Flutter run key commands.
r Hot reload.
q Quit.
```

## ✅ Testing the System

### Test 1: Backend Health

```bash
curl http://localhost:5000/health
```

Response:
```json
{"status":"OK","message":"Backend server is running"}
```

### Test 2: Get Symptoms

```bash
curl http://localhost:5000/api/symptoms
```

### Test 3: Analyze Symptoms

```bash
curl -X POST http://localhost:5000/api/analyze-symptoms \
  -H "Content-Type: application/json" \
  -d "{\"symptoms\":[\"Fever\",\"Cough\"]}"
```

### Test 4: ML API Health

```bash
curl http://localhost:5001/health
```

Response:
```json
{"status":"OK","model_loaded":true}
```

## 🔧 Troubleshooting

### Issue: Port 5000/5001 Already in Use

```bash
# Windows - Find process using port
netstat -ano | findstr :5000

# Kill process
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:5000 | xargs kill -9
```

### Issue: Flutter App Crashes

1. Check backend is running: `curl http://localhost:5000/health`
2. Check ML API is running: `curl http://localhost:5001/health`
3. Try rebuilding: `flutter clean && flutter pub get`
4. Check emulator IP - for physical device, update `api_service.dart`:

```dart
static const String baseUrl = 'http://YOUR_DEVICE_IP:5000';
```

### Issue: ML Model Not Found

```bash
cd ml
python train.py  # Regenerate model
```

### Issue: Python Dependencies

```bash
# Upgrade pip
python -m pip install --upgrade pip

# Reinstall requirements
pip install --force-reinstall -r requirements.txt
```

## 📊 System Status

After all 3 terminals are running, you should see:

```
Terminal 1 (Backend):
✓ Backend server running on http://localhost:5000
✓ ML API: http://localhost:5001

Terminal 2 (ML API):
✓ Listening on http://localhost:5001
MODEL_LOADED: True

Terminal 3 (Flutter):
✓ App running on Android emulator
Dart VM Service available at: http://127.0.0.1:XXXXX
```

## 📱 Using the App

1. **Welcome Screen** - Tap "Get Started"
2. **User Details** - Enter name, age, location
3. **Symptoms** - Select symptoms you're experiencing
4. **Loading** - App processes data
5. **Results** - View diagnosis and recommendations
6. **Clinics** - See nearby healthcare facilities
7. **First Aid** - Get immediate care tips

## 🔄 Common Operations

### Hot Reload Flutter
While app is running:
```
Press 'r' in terminal
```

### Restart Backend
```
Terminal 1: Ctrl+C then npm start
```

### Retrain ML Model
```bash
cd ml
# Update datasets/train.csv with new data
python train.py
# Restart Flask API
```

## 💡 Next Steps

- [ ] Add database for data persistence
- [ ] Implement user authentication
- [ ] Deploy backend to cloud
- [ ] Add more symptoms to training data
- [ ] Implement real location services
- [ ] Add appointment booking feature

## 📞 Support

For issues:
1. Check logs in each terminal
2. Verify all prerequisites are installed
3. Try restarting each component
4. Check firewall settings

---

**Status**: ✅ Ready for Development

**Last Updated**: January 25, 2026
