import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzy/pages/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzy',
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
        primaryColor: Color.fromRGBO(16, 66, 148, 1), // Couleur primaire
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(16, 66, 148, 1), // Couleur de l'AppBar
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
