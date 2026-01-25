import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
import joblib
import os

# Load training data
def load_data(train_path, test_path):
    """Load training and testing data"""
    try:
        train_df = pd.read_csv(train_path)
        test_df = pd.read_csv(test_path)
        print(f"✓ Training data loaded: {train_df.shape[0]} samples, {train_df.shape[1]} features")
        print(f"✓ Testing data loaded: {test_df.shape[0]} samples, {test_df.shape[1]} features")
        return train_df, test_df
    except FileNotFoundError as e:
        print(f"Error: {e}")
        return None, None

def prepare_data(train_df, test_df):
    """Prepare data for training"""
    # Get common columns (excluding prognosis)
    train_features = train_df.columns[:-1]
    test_features = test_df.columns[:-1]
    
    # Find common features
    common_features = [col for col in train_features if col in test_features]
    print(f"Common features: {len(common_features)}")
    
    # Extract features and labels
    X_train = train_df[common_features].values
    y_train = train_df['prognosis'].values
    
    X_test = test_df[common_features].values
    y_test = test_df['prognosis'].values
    
    # Encode labels
    le = LabelEncoder()
    y_train_encoded = le.fit_transform(y_train)
    y_test_encoded = le.transform(y_test)
    
    print(f"\n✓ Features used: {len(common_features)}")
    print(f"✓ Unique diseases: {len(le.classes_)}")
    print(f"✓ Sample diseases: {', '.join(le.classes_[:5])}...")
    
    return X_train, X_test, y_train_encoded, y_test_encoded, common_features, le

def train_model(X_train, X_test, y_train, y_test):
    """Train the classification model"""
    print("\n🔄 Training Random Forest Classifier...")
    
    model = RandomForestClassifier(
        n_estimators=200,
        max_depth=30,
        random_state=42,
        n_jobs=-1,
        verbose=0
    )
    
    model.fit(X_train, y_train)
    
    # Evaluate
    train_score = model.score(X_train, y_train)
    test_score = model.score(X_test, y_test)
    
    print(f"\n📊 Model Performance:")
    print(f"   Training accuracy:  {train_score:.4f} ({train_score*100:.2f}%)")
    print(f"   Testing accuracy:   {test_score:.4f} ({test_score*100:.2f}%)")
    
    return model

def save_model(model, feature_names, label_encoder):
    """Save model and preprocessing objects"""
    os.makedirs('models', exist_ok=True)
    
    joblib.dump(model, 'models/diagnosis_model.pkl')
    joblib.dump(feature_names, 'models/feature_names.pkl')
    joblib.dump(label_encoder, 'models/label_encoder.pkl')
    
    print("\n💾 Model saved successfully")
    print(f"   - models/diagnosis_model.pkl")
    print(f"   - models/feature_names.pkl")
    print(f"   - models/label_encoder.pkl")

def main():
    print("="*60)
    print("   AI Symptom Checker - ML Model Training")
    print("="*60)
    
    # Load data
    print("\n🔄 Loading medical datasets...")
    train_df, test_df = load_data('../datasets/Training.csv', '../datasets/Testing.csv')
    
    if train_df is None:
        print("❌ Failed to load data")
        return
    
    # Prepare data
    print("\n🔄 Preparing data...")
    X_train, X_test, y_train, y_test, features, le = prepare_data(train_df, test_df)
    
    # Train model
    model = train_model(X_train, X_test, y_train, y_test)
    
    # Save model
    save_model(model, features, le)
    
    print("\n" + "="*60)
    print("✅ Training complete!")
    print("="*60)

if __name__ == '__main__':
    main()

