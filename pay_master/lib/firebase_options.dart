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
    apiKey: 'AIzaSyB_nKgX_r_O2K6yATD5cYfCMMLhOZLitgg',
    appId: '1:18767244360:web:3a6216d190311ccf40bc7d',
    messagingSenderId: '18767244360',
    projectId: 'pay-master-fea0a',
    authDomain: 'pay-master-fea0a-14ad3.firebaseapp.com',
    storageBucket: 'pay-master-fea0a.appspot.com',
    measurementId: 'G-8ZVENLR1GW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyDGVtJxWVeA00RgQXqcG4qXO7lQpNJw8',
    appId: '1:18767244360:android:28eb6e84c93b930d40bc7d',
    messagingSenderId: '18767244360',
    projectId: 'pay-master-fea0a',
    storageBucket: 'pay-master-fea0a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVPIttGsu6AO4o8j4gAW2Z-W1AXLoZwwc',
    appId: '1:18767244360:ios:cab0a374727a44e640bc7d',
    messagingSenderId: '18767244360',
    projectId: 'pay-master-fea0a',
    storageBucket: 'pay-master-fea0a.appspot.com',
    iosClientId:
        '18767244360-gg69rc1gvetg4rmlgvu7fam3rsimei8a.apps.googleusercontent.com',
    iosBundleId: 'com.example.payMaster',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVPIttGsu6AO4o8j4gAW2Z-W1AXLoZwwc',
    appId: '1:18767244360:ios:9a4943e2e6d06d5b40bc7d',
    messagingSenderId: '18767244360',
    projectId: 'pay-master-fea0a',
    storageBucket: 'pay-master-fea0a.appspot.com',
    iosClientId:
        '18767244360-mnjcal5gm60lgfkli4c7ennh5fiipljs.apps.googleusercontent.com',
    iosBundleId: 'com.example.payMaster.RunnerTests',
  );
}
