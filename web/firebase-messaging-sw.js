// Required by firebase_messaging on Flutter Web. Without this file, calls
// like FirebaseMessaging.instance.getToken() can hang indefinitely waiting
// for a service worker that never registers.
//
// IMPORTANT: replace the config below with your real values from the
// Firebase console (Project settings > General > Your apps > Web app) once
// you have a real project set up. The dummy values here let the app boot
// and getToken() fail fast instead of hanging.

importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: 'AIzaSyDummyKeyForDevelopment',
  appId: '1:123456789:web:abcdef',
  messagingSenderId: '123456789',
  projectId: 'mariavaicomoutras-e7c28',
  authDomain: 'mariavaicomoutras-e7c28.firebaseapp.com',
  storageBucket: 'mariavaicomoutras-e7c28.appspot.com',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('Mensagem recebida em background: ', payload);
});
