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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ-lD9zRlfxMcyds0xol2SE6gAe2KIyiU',
    appId: '1:176099223072:android:1577ac5965e7f936367e45',
    messagingSenderId: '176099223072',
    projectId: 'sscconnect-air',
    storageBucket: 'sscconnect-air.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDz975HQkiCRMZBVUVD_ZM8ZUk-oBgn7k0',
    appId: '1:176099223072:ios:2735ded9025c2687367e45',
    messagingSenderId: '176099223072',
    projectId: 'sscconnect-air',
    storageBucket: 'sscconnect-air.appspot.com',
    androidClientId:
        '176099223072-30kcu1nlj4av5u83517jlrt1nb8ltmi7.apps.googleusercontent.com',
    iosClientId:
        '176099223072-ro1egkq0aab07e191otsgbc4n0ggus0i.apps.googleusercontent.com',
    iosBundleId: 'com.SSPConnect.app',
  );
}