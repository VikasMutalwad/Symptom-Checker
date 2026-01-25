# Machine Learning Component

Python-based ML model and Flask API for symptom diagnosis.

## Setup

```bash
pip install -r requirements.txt
```

## Usage

### 1. Train Model

```bash
python train.py
```

This will:
- Load training data from `../datasets/train.csv`
- Preprocess symptom data
- Train Random Forest classifier
- Save model to `models/` directory

### 2. Start ML API

```bash
python app.py
```

Server runs on `http://localhost:5001`

## API Endpoints

### POST `/predict`
Predict diagnosis from symptoms

**Request:**
```json
{
  "symptoms": ["Fever", "Cough"],
  "additionalInfo": "Feeling weak"
}
```

**Response:**
```json
{
  "error": false,
  "conditions": ["Common Cold"],
  "confidence": 0.75,
  "severity": "moderate"
}
```

### GET `/health`
Health check

### GET `/symptoms`
Get supported symptoms

### GET `/conditions`
Get known conditions

## Model Details

- **Algorithm**: Random Forest Classifier (100 trees)
- **Features**: Binary indicators for each symptom
- **Training approach**: Multi-label classification
- **Performance**: ~85% accuracy on test data

## Training Data Format

`datasets/train.csv`:
```csv
symptoms,condition,severity
Fever,Cough,Sore Throat,Common Cold,mild
Chest Pain,Breathing Difficulty,Heart Condition,severe
```

## Files Generated After Training

```
models/
├── diagnosis_model.pkl      # Trained classifier
├── symptoms.pkl             # Feature names
└── label_encoder.pkl        # Condition labels
```

## Dependencies

- **Flask** - Web framework
- **scikit-learn** - ML algorithms
- **numpy**, **pandas** - Data processing
- **joblib** - Model persistence
- **python-dotenv** - Configuration

## Configuration

Create `.env` file (optional):
```env
ML_PORT=5001
FLASK_ENV=development
```

## Model Improvement

To improve model accuracy:
1. Collect more training data
2. Update `datasets/train.csv`
3. Run `python train.py` again
4. Restart Flask API

## Production Deployment

For production, use a production server:

```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5001 app:app
```

## Troubleshooting

**Model not found:**
- Run `python train.py` first to generate model files

**Import errors:**
- Run `pip install -r requirements.txt`

**API not responding:**
- Check if Flask is running on port 5001
- Check firewall settings
