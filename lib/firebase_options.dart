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
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBzSp053hINdk0iYpUMDj1ruqo5GYfKYPE',
    appId: '1:609634905109:web:e83be8947d9403a8a2721c',
    messagingSenderId: '609634905109',
    projectId: 'online-tasks-app',
    authDomain: 'online-tasks-app.firebaseapp.com',
    storageBucket: 'online-tasks-app.appspot.com',
    measurementId: 'G-84NB162W2G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqgb09cuODNHrSXjhJujQ4aqxtVtPA7go',
    appId: '1:609634905109:android:544b6f7d48e77fe0a2721c',
    messagingSenderId: '609634905109',
    projectId: 'online-tasks-app',
    storageBucket: 'online-tasks-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeIOKEBjVNaYyLADgUkQGYt0McZX_p0Pg',
    appId: '1:609634905109:ios:b4452c9ffaad671ba2721c',
    messagingSenderId: '609634905109',
    projectId: 'online-tasks-app',
    storageBucket: 'online-tasks-app.appspot.com',
    iosBundleId: 'com.example.todoListApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDeIOKEBjVNaYyLADgUkQGYt0McZX_p0Pg',
    appId: '1:609634905109:ios:53d39a9aa6b21ce7a2721c',
    messagingSenderId: '609634905109',
    projectId: 'online-tasks-app',
    storageBucket: 'online-tasks-app.appspot.com',
    iosBundleId: 'com.example.todoListApp.RunnerTests',
  );
}
