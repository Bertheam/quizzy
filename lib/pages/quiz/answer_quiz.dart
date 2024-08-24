import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerQuiz extends StatefulWidget {
  const AnswerQuiz({super.key});

  @override
  State<AnswerQuiz> createState() => _AnswerQuizState();
}

class _AnswerQuizState extends State<AnswerQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.white)),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de progression
            LinearProgressIndicator(
              value: 0.6, // 60% du quiz est complété
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 20),

            // Carte de la question
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: 150,
                  //   color: Colors.orange,
                  //   margin: EdgeInsets.only(bottom: 16),
                  // ),
                  Center(
                    child: Text(
                      'What Color is it ?',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),

            // Options de réponse
            Expanded(
              flex: 8,
              child: ListView(
                children: [
                  buildOption('青'),
                  buildOption('オレンジ'),
                  buildOption('黒'),
                  buildOption('白'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Text('Suivant',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Fonction pour construire les options
  Widget buildOption(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          text,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        onTap: () {
          // Ajouter la logique pour la sélection de l'option ici
        },
      ),
    );
  }
}
