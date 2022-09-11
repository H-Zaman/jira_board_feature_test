importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyBjukV7gqZUs4G76ZAU1HB4PU3OCGeH90g",
    authDomain: "vnotifyu-afd78.firebaseapp.com",
    projectId: "vnotifyu-afd78",
    storageBucket: "vnotifyu-afd78.appspot.com",
    messagingSenderId: "873148419067",
    appId: "1:873148419067:web:b1e9a895019d2b2197d95e",
    measurementId: "G-L0FLJZV2LW"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});