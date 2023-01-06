import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/home.dart';
import 'package:ticket_wisata_donorojo/app/modules/splash/splash_screen.dart';
// import 'package:ticket_wisata_donorojo/app/modules/home/views/home_view.dart';

// import 'app/modules/home/views/snap_view.dart';
import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(GetMaterialApp(
    theme: new ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
    debugShowCheckedModeBanner: false,
    title: "Application",
    home: SplashScreen(),
    getPages: AppPages.routes,
  ));
  // MaterialApp(
  //     // ignore: unnecessary_new
  //     theme: new ThemeData(
  //         scaffoldBackgroundColor:
  //             const Color.fromARGB(255, 255, 255, 255)),
  //     debugShowCheckedModeBanner: false,
  //     home: SplashScreen()));
}
