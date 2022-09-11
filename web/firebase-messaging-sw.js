importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBjukV7gqZUs4G76ZAU1HB4PU3OCGeH90g",
  authDomain: "vnotifyu-afd78.firebaseapp.com",
  databaseURL: "https://vnotifyu-afd78-default-rtdb.firebaseio.com",
  projectId: "vnotifyu-afd78",
  storageBucket: "vnotifyu-afd78.appspot.com",
  messagingSenderId: "873148419067",
  appId: "1:873148419067:web:b1e9a895019d2b2197d95e",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});