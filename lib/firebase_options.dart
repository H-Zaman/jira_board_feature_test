// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBjukV7gqZUs4G76ZAU1HB4PU3OCGeH90g',
    appId: '1:873148419067:web:b1e9a895019d2b2197d95e',
    messagingSenderId: '873148419067',
    projectId: 'vnotifyu-afd78',
    authDomain: 'vnotifyu-afd78.firebaseapp.com',
    storageBucket: 'vnotifyu-afd78.appspot.com',
    measurementId: 'G-L0FLJZV2LW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArFDtzmM1LAT3FgIimSkxuxAa076YsEo8',
    appId: '1:873148419067:android:8bd3534fbc01cbf497d95e',
    messagingSenderId: '873148419067',
    projectId: 'vnotifyu-afd78',
    storageBucket: 'vnotifyu-afd78.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6MixwndwOoihXEpapHGEIYinrtehiKLs',
    appId: '1:873148419067:ios:928fd912a6a1a06097d95e',
    messagingSenderId: '873148419067',
    projectId: 'vnotifyu-afd78',
    storageBucket: 'vnotifyu-afd78.appspot.com',
    iosClientId: '873148419067-r98ejugfo2q1nhi0rvi2vrnk6j3od7a9.apps.googleusercontent.com',
    iosBundleId: 'com.prodify.vnotifyu',
  );
}
