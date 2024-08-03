import 'package:flutter/material.dart';
import 'package:quizzy/pages/accueil_page.dart';
import 'package:quizzy/pages/bottom_navigation.dart';
import 'package:quizzy/pages/profil_page.dart';
import 'package:quizzy/pages/quiz/index_quiz.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    const AccueilPage(),
    const IndexQuiz(),
    const ProfilPage()
  ];

  void navigateBottomBar(index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
