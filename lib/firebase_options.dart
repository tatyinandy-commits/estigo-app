import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDzHfMWxV7x8iutlcZymCc2Cr180xzpuEI',
    appId: '1:40756661934:web:b640b4e9d39c3e483a273f',
    messagingSenderId: '40756661934',
    projectId: 'estigo-mobile',
    storageBucket: 'estigo-mobile.firebasestorage.app',
    authDomain: 'estigo-mobile.firebaseapp.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgTgR4u9H4sNmv7-0RUqmx82N2mYro0r4',
    appId: '1:40756661934:android:42aa6d66d48e14623a273f',
    messagingSenderId: '40756661934',
    projectId: 'estigo-mobile',
    storageBucket: 'estigo-mobile.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuQjyf0AKHMNc6Suops9zODqc6P28nxV4',
    appId: '1:40756661934:ios:6702d9826b05e8553a273f',
    messagingSenderId: '40756661934',
    projectId: 'estigo-mobile',
    storageBucket: 'estigo-mobile.firebasestorage.app',
    iosBundleId: 'org.estigo.app',
  );
}
