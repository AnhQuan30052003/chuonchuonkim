import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyC4nJGfeC57_p5hKXEEPO1iVqmbpiT-d9k',
    appId: '1:6854883975:android:1e1f2f9b2ae414b7929622',
    messagingSenderId: '6854883975',
    projectId: 'chuonchuonkim-a7c61',
    storageBucket: 'chuonchuonkim-a7c61.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-ik0mP5ccBuejWkMJy5q26tApwhOwF38',
    appId: '1:6854883975:ios:2d2677a4ffcc6830929622',
    messagingSenderId: '6854883975',
    projectId: 'chuonchuonkim-a7c61',
    storageBucket: 'chuonchuonkim-a7c61.appspot.com',
    iosBundleId: 'com.example.chuonchuonkimApp',
  );
}
