
// The Firebase Admin SDK to access Firestore.
// const initializeApp = require("firebase-admin/app");
const admin = require("firebase-admin");
const functions = require('firebase-functions/v1');

admin.initializeApp();


exports.onCreateUser = functions.auth.user().onCreate((user: any) => {
    admin.firestore().collection('users').doc(user.uid).set({
        email: user.email,
        uid: user.uid,
        photoURL: '',       
    });
});

function getPathStorageFromUrl(url:String){

    const baseUrl = "https://firebasestorage.googleapis.com/v0/b/mediashare-cd7fc.appspot.com/o/";

    let mediaPath:string = url.replace(baseUrl,"");

    const indexOfEndPath = mediaPath.indexOf("?");

   mediaPath =mediaPath.substring(0,indexOfEndPath);
    
    mediaPath =mediaPath.replace(/%2F/g,"/");
    
 
    return mediaPath;
}

//on post delete
exports.onPostDelete = functions.firestore.document('posts/{postId}').onDelete(async(snap:any, context:any) => {
    const postData = snap.data();
    const mediaDownloadUrl = postData.mediaUrl;
    const thumbnailDownloadUrl = postData.thumbnailUrl;
    const mediaPath = getPathStorageFromUrl(mediaDownloadUrl);
    const thumbnailPath = getPathStorageFromUrl(thumbnailDownloadUrl);

    const bucket = admin.storage().bucket();
    await bucket.file(thumbnailPath).delete();
    return bucket.file(mediaPath).delete();

});

