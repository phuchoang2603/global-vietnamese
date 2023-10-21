import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDyFeRsYV3Dij5nK4NAusmsridBImuH_gQ",
            authDomain: "global-vietnamese.firebaseapp.com",
            projectId: "global-vietnamese",
            storageBucket: "global-vietnamese.appspot.com",
            messagingSenderId: "788089873690",
            appId: "1:788089873690:web:fdc722b891ce174abe38a3",
            measurementId: "G-VCNWZF98KG"));
  } else {
    await Firebase.initializeApp();
  }
}
