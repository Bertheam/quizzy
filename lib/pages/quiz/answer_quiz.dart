import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerQuiz extends StatefulWidget {
  const AnswerQuiz({super.key});

  @override
  State<AnswerQuiz> createState() => _AnswerQuizState();
}

class _AnswerQuizState extends State<AnswerQuiz> {
  // Liste des questions et réponses
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Quel est le plus grand pays du monde par superficie ?',
      'options': ['Russie', 'Canada', 'Chine', 'États-Unis'],
      'correctAnswer': 0,
    },
    {
      'question': 'Quelle est la capitale de l\'Italie ?',
      'options': ['Madrid', 'Rome', 'Berlin', 'Paris'],
      'correctAnswer': 1,
    },
    {
      'question': 'Quelle est la capitale de la Pologne ?',
      'options': ['Madrid', 'Londre', 'Varsovie', 'Venise'],
      'correctAnswer': 2,
    },
    {
      'question': 'Quelle est la capitale de le Portugal ?',
      'options': ['Porto', 'Lisbonne', 'Berlin', 'Paris'],
      'correctAnswer': 1,
    },
    {
      'question': 'Quelle est la capitale du Mali ?',
      'options': ['Soweto', 'Abidjan', 'Kayes', 'Bamako'],
      'correctAnswer': 3,
    }
  ];

  int currentQuestionIndex = 0;
  var selectedOptionIndex;
  int score = 0;

  // Fonction pour passer à la question suivante
  void _nextQuestion() {
    if (selectedOptionIndex == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
    }

    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null;  // Réinitialiser la sélection
      } else {
        // Fin du quiz, afficher un dialogue avec le score
        _showScoreDialog();
      }
    });
  }

  // Fonction pour afficher le score final
  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Terminé'),
        content: Text('Votre score est de $score/${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                score = 0;
                currentQuestionIndex = 0;
                selectedOptionIndex = null;
              });
            },
            child: Text('Recommencer'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text(
          'Répondez au Quiz',
          style: TextStyle(color: Colors.white,fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(16, 66, 148, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Affichage de la question
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: GoogleFonts.lato(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  question['question'],
                  style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Affichage des options
            ...List.generate(question['options'].length, (index) {
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    question['options'][index],
                    style: GoogleFonts.lato(fontSize: 18),
                  ),
                  leading: Radio(
                    value: index,
                    groupValue: selectedOptionIndex,
                    onChanged: (var value) {
                      setState(() {
                        selectedOptionIndex = value!;
                      });
                    },
                  ),
                ),
              );
            }),

            Spacer(),

            // Bouton pour passer à la question suivante
            ElevatedButton(
              onPressed: selectedOptionIndex == null ? null : _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(16, 66, 148, 1),
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Suivant',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
