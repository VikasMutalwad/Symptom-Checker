from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import numpy as np
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
CORS(app)

# Load model and preprocessing objects
MODEL_DIR = 'models'
model = None
feature_names = None
label_encoder = None

def load_model():
    """Load trained model and preprocessing objects"""
    global model, feature_names, label_encoder
    
    try:
        model = joblib.load(os.path.join(MODEL_DIR, 'diagnosis_model.pkl'))
        feature_names = joblib.load(os.path.join(MODEL_DIR, 'feature_names.pkl'))
        label_encoder = joblib.load(os.path.join(MODEL_DIR, 'label_encoder.pkl'))
        print("✓ Model loaded successfully")
        print(f"✓ Features: {len(feature_names)}")
        print(f"✓ Diseases: {len(label_encoder.classes_)}")
        return True
    except FileNotFoundError:
        print("⚠ Model files not found. Please train the model first.")
        return False

def convert_symptoms_to_features(symptoms):
    """Convert symptom names to feature vector"""
    if not feature_names:
        return None
    
    # Normalize symptom names to lowercase with underscores
    normalized_symptoms = [s.lower().replace(' ', '_') for s in symptoms]
    
    # Create binary features
    features = np.array([1 if fname.lower() in normalized_symptoms else 0 
                        for fname in feature_names])
    return features.reshape(1, -1)

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({
        'status': 'OK',
        'message': 'ML API is running',
        'model_loaded': model is not None,
        'features': len(feature_names) if feature_names else 0,
        'diseases': len(label_encoder.classes_) if label_encoder else 0
    })

@app.route('/predict', methods=['POST'])
def predict():
    """Predict diagnosis from symptoms"""
    try:
        data = request.json
        symptoms = data.get('symptoms', [])
        additional_info = data.get('additionalInfo', '')
        
        if not symptoms:
            return jsonify({
                'error': True,
                'message': 'No symptoms provided'
            }), 400
        
        if model is None:
            return jsonify({
                'error': True,
                'message': 'Model not loaded. Please train the model first.'
            }), 500
        
        # Convert symptoms to features
        features = convert_symptoms_to_features(symptoms)
        
        if features is None:
            return jsonify({
                'error': True,
                'message': 'Failed to process symptoms'
            }), 400
        
        # Make prediction
        prediction = model.predict(features)[0]
        probabilities = model.predict_proba(features)[0]
        confidence = np.max(probabilities)
        
        # Decode prediction
        disease = label_encoder.inverse_transform([prediction])[0]
        
        # Determine severity based on confidence
        if confidence > 0.85:
            severity = 'severe'
        elif confidence > 0.65:
            severity = 'moderate'
        else:
            severity = 'mild'
        
        return jsonify({
            'error': False,
            'conditions': [disease],
            'confidence': float(confidence),
            'severity': severity,
            'symptoms_used': symptoms,
            'additional_info': additional_info
        })
    
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({
            'error': True,
            'message': str(e)
        }), 500

@app.route('/symptoms', methods=['GET'])
def get_symptoms():
    """Get list of supported symptoms"""
    if feature_names is None:
        return jsonify({
            'error': True,
            'message': 'Model not loaded'
        }), 500
    
    # Convert feature names back to readable format
    readable_symptoms = [name.replace('_', ' ').title() for name in feature_names]
    
    return jsonify({
        'error': False,
        'symptoms': readable_symptoms,
        'total': len(readable_symptoms)
    })

@app.route('/diseases', methods=['GET'])
def get_diseases():
    """Get list of known diseases"""
    if label_encoder is None:
        return jsonify({
            'error': True,
            'message': 'Model not loaded'
        }), 500
    
    diseases = list(label_encoder.classes_)
    return jsonify({
        'error': False,
        'diseases': diseases,
        'total': len(diseases)
    })

if __name__ == '__main__':
    PORT = int(os.getenv('ML_PORT', 5001))
    
    print("🚀 Starting ML API...")
    if load_model():
        print(f"✓ Listening on http://localhost:{PORT}")
        app.run(host='0.0.0.0', port=PORT, debug=False)
    else:
        print("⚠ Starting without model. Train model first with: python train.py")
        print(f"✓ Listening on http://localhost:{PORT}")
        app.run(host='0.0.0.0', port=PORT, debug=False)

