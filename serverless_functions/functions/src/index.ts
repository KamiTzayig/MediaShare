
// The Firebase Admin SDK to access Firestore.
// const initializeApp = require("firebase-admin/app");
const admin = require("firebase-admin");
const functions = require('firebase-functions/v1');

admin.initializeApp();

// initializeApp();

exports.onCreateUser = functions.auth.user().onCreate((user: any) => {
    admin.firestore().collection('users').doc(user.uid).set({
        email: user.email,
        uid: user.uid,
        photoURL: '',       
    });
});
