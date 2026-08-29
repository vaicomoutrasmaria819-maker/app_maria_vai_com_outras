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
  apiKey: 'AIzaSyAwMkkGeYdJb-TvozXHMIJz8XReoxuKHq4',
  appId: '1:998255141329:web:5cb6c9f3c7c09d142bc0f0',
  messagingSenderId: '998255141329',
  projectId: 'mariavaicomoutras-e7c28',
  authDomain: 'mariavaicomoutras-e7c28.firebaseapp.com',
  storageBucket: 'mariavaicomoutras-e7c28.firebasestorage.app',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('Mensagem recebida em background: ', payload);
});
