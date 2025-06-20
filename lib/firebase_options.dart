// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBMVERpUvrkqU3j8EGJ0M01bQscsmk6IQg',
    appId: '1:393363419042:web:14ebfbe09b144b756cccfb',
    messagingSenderId: '393363419042',
    projectId: 'flutter-chat-app-demo-6a11d',
    authDomain: 'flutter-chat-app-demo-6a11d.firebaseapp.com',
    storageBucket: 'flutter-chat-app-demo-6a11d.firebasestorage.app',
    measurementId: 'G-1JCNTYD7B3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6Z-6D8tPOmFKMl4Bzkjqp-L9ErViv7DY',
    appId: '1:393363419042:android:3dfffcfcaedbbf9f6cccfb',
    messagingSenderId: '393363419042',
    projectId: 'flutter-chat-app-demo-6a11d',
    storageBucket: 'flutter-chat-app-demo-6a11d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlEY8RKycatFCMWkzxo4TZhTBdWBRCi68',
    appId: '1:393363419042:ios:964fb5adb8cdf6916cccfb',
    messagingSenderId: '393363419042',
    projectId: 'flutter-chat-app-demo-6a11d',
    storageBucket: 'flutter-chat-app-demo-6a11d.firebasestorage.app',
    iosBundleId: 'com.example.flutterChatAppDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAlEY8RKycatFCMWkzxo4TZhTBdWBRCi68',
    appId: '1:393363419042:ios:964fb5adb8cdf6916cccfb',
    messagingSenderId: '393363419042',
    projectId: 'flutter-chat-app-demo-6a11d',
    storageBucket: 'flutter-chat-app-demo-6a11d.firebasestorage.app',
    iosBundleId: 'com.example.flutterChatAppDemo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBMVERpUvrkqU3j8EGJ0M01bQscsmk6IQg',
    appId: '1:393363419042:web:26c3908bb66046726cccfb',
    messagingSenderId: '393363419042',
    projectId: 'flutter-chat-app-demo-6a11d',
    authDomain: 'flutter-chat-app-demo-6a11d.firebaseapp.com',
    storageBucket: 'flutter-chat-app-demo-6a11d.firebasestorage.app',
    measurementId: 'G-Z50PLDDDED',
  );
}
