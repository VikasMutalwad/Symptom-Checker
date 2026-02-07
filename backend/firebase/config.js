const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json'); // You'll need to add this file

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: process.env.FIREBASE_DATABASE_URL
});

const db = admin.firestore();

module.exports = { admin, db };