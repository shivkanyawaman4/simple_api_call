import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'screens/main_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD5a-Mn2UngrsljqSG_CQkD5FV8kKqYbMY",
            authDomain: "keshri-e006d.firebaseapp.com",
            projectId: "keshri-e006d",
            storageBucket: "keshri-e006d.appspot.com",
            messagingSenderId: "805128617970",
            appId: "1:805128617970:web:404f1f84ba0ef04bc3756b",
            measurementId: "G-K1BNZGXNCH"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: [
          const ResponsiveBreakpoint.resize(350, name: MOBILE),
          const ResponsiveBreakpoint.resize(600, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.resize(1700, name: 'XL'),
        ],
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.workSans().fontFamily,
        textTheme: const TextTheme(
          headline2: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          headline3: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.normal),
          headline4: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          headline5: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w200),
        ),
        primarySwatch: Colors.green,
      ),
      home: const MainPage(),
    );
  }
}
