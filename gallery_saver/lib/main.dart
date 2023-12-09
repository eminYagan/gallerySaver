import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/pages/photo_List_Page.dart';
import 'package:get/get.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyA8pYraPsOytB-uCVbwQFwCDtYM2o_m0nw",
    appId: "1:663500872923:android:da34f67d61041319ba80fe",
    messagingSenderId: "663500872923",
    projectId: "gallerysaver-c3c53",
  );

  await Firebase.initializeApp(options: firebaseOptions);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhotoListPage(),
    );
  }
}
