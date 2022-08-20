import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordermanagement/src/app/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Demo Board Management Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.dmSansTextTheme(),
        scaffoldBackgroundColor: Colors.white
      ),
      home: const SplashScreen(),
    );
  }
}