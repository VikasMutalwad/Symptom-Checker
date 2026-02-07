const admin = require('firebase-admin');
let db = null;
let initialized = false;

try {
  // Try loading local service account file if present
  const serviceAccount = require('./serviceAccountKey.json');
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: process.env.FIREBASE_DATABASE_URL
  });
  db = admin.firestore();
  initialized = true;
} catch (err) {
  // If local file not present, try environment variable with JSON credentials
  try {
    if (process.env.FIREBASE_CREDENTIALS) {
      const creds = JSON.parse(process.env.FIREBASE_CREDENTIALS);
      admin.initializeApp({
        credential: admin.credential.cert(creds),
        databaseURL: process.env.FIREBASE_DATABASE_URL
      });
      db = admin.firestore();
      initialized = true;
    }
  } catch (err2) {
    // swallow parse/init errors
  }
}

if (!initialized) {
  console.warn('Firebase not initialized - running without Firestore. Set FIREBASE_CREDENTIALS or add firebase/serviceAccountKey.json to enable logging.');
  // Provide a lightweight mock DB with the needed `collection().add()` API so app doesn't crash
  db = {
    collection: (name) => ({
      add: async (obj) => {
        console.warn(`Mock add to collection ${name}:`, obj && obj.timestamp ? obj.timestamp : '[no timestamp]');
        return Promise.resolve({ id: 'mock-id' });
      }
    })
  };
}

module.exports = { admin: initialized ? admin : null, db };