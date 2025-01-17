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
    apiKey: 'AIzaSyCE2jQV-y5VObVezY90VtSDYuHxVfbmg08',
    appId: '1:662041892432:web:bc4e3fd09bdec2b9c86355',
    messagingSenderId: '662041892432',
    projectId: 'hedieaty-32513',
    authDomain: 'hedieaty-32513.firebaseapp.com',
    storageBucket: 'hedieaty-32513.firebasestorage.app',
    measurementId: 'G-STHVFDPFL4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5lnJKufBd9j3j3n7dZeF7EerFrjhqCFk',
    appId: '1:662041892432:android:816294179df92945c86355',
    messagingSenderId: '662041892432',
    projectId: 'hedieaty-32513',
    storageBucket: 'hedieaty-32513.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC122LMldLyS90O2U5sBpMTgV7KcqEpJfc',
    appId: '1:662041892432:ios:cd248b610f6d3499c86355',
    messagingSenderId: '662041892432',
    projectId: 'hedieaty-32513',
    storageBucket: 'hedieaty-32513.firebasestorage.app',
    iosBundleId: 'com.example.hedieaty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC122LMldLyS90O2U5sBpMTgV7KcqEpJfc',
    appId: '1:662041892432:ios:cd248b610f6d3499c86355',
    messagingSenderId: '662041892432',
    projectId: 'hedieaty-32513',
    storageBucket: 'hedieaty-32513.firebasestorage.app',
    iosBundleId: 'com.example.hedieaty',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCE2jQV-y5VObVezY90VtSDYuHxVfbmg08',
    appId: '1:662041892432:web:87a306139d06961ec86355',
    messagingSenderId: '662041892432',
    projectId: 'hedieaty-32513',
    authDomain: 'hedieaty-32513.firebaseapp.com',
    storageBucket: 'hedieaty-32513.firebasestorage.app',
    measurementId: 'G-1R4QG5DJNE',
  );

}