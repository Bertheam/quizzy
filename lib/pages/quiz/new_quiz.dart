import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quizzy/global/variable.dart';
import 'package:quizzy/models/question.dart';
import 'package:quizzy/models/quiz.dart';
import 'package:quizzy/pages/teacher/teacher_home_page.dart';

class NewQuiz extends StatefulWidget {
  const NewQuiz({super.key});

  @override
  State<NewQuiz> createState() => _NewQuizState();
}

class _NewQuizState extends State<NewQuiz> {
  final _formKey = GlobalKey<FormState>();
  List<Question> _questions = [];
  String _quizNom = '';
  String _quizDescription = '';
  String _quizTheme = '';
  bool isLoading = false;
  var isDeviceConnected = false;
  bool isOnline = false;
  Variable variable = Variable();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Créer un Quiz",style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(16, 66, 148, 1),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back,color: Colors.white)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nom du Quiz"),
                onSaved: (value) {
                  _quizNom = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom de quiz';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                onSaved: (value) {
                  _quizDescription = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Thème"),
                onSaved: (value) {
                  _quizTheme = value!;
                },
              ),
              Expanded(
                child: ListView.builder(
                  primary: false,
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return _buildQuestionCard(index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _addQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(16, 66, 148, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Ajouter une Question",style: TextStyle(color: Colors.white),),
                  ),
                  ElevatedButton(
                    onPressed: _submitQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(16, 66, 148, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:isLoading ? CircularProgressIndicator(color: Colors.white,) : Text("Créer le Quiz",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _questions[index].enonceController,
              decoration: InputDecoration(labelText: "Question ${index + 1}"),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: _questions[index].reponsesControllers.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: TextFormField(
                    controller: _questions[index].reponsesControllers[i],
                    decoration: InputDecoration(labelText: "Réponse ${i + 1}"),
                  ),
                  leading: Radio<int>(
                    value: i,
                    groupValue: _questions[index].bonneReponseIndex,
                    onChanged: (value) {
                      setState(() {
                        _questions[index].bonneReponseIndex = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addQuestion() {
    if (_questions.length < 20) {
      setState(() {
        _questions.add(
          Question(
            id: _questions.length + 1,
            enonceController: TextEditingController(),
            reponsesControllers: List.generate(4, (index) => TextEditingController()),
            bonneReponseIndex: 0,
          ),
        );
      });
    } else {
      // Limiter à 20 questions
    }
  }

  Future<void> _submitQuiz() async {
    var authUserId = await variable.getAuthUserId();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Préparer les données des questions pour l'API
      List<Map<String, dynamic>> questionsData = _questions.map((question) {
        return {
          'enonce': question.enonceController.text,
          'reponses': question.reponsesControllers.map((controller) => controller.text).toList(),
          'bonne_reponse_index': question.bonneReponseIndex,
        };
      }).toList();

      // Construire le payload du quiz
      Map<String, dynamic> quizData = {
        'nom': _quizNom,
        'description': _quizDescription,
        'theme': _quizTheme,
        'user_id': authUserId?.toInt(),
        'questions': questionsData,
      };

      setState(() => isLoading = true);

      // Envoi des données au backend
      final response = await post(
        Uri.parse("${variable.apiUrl}/create-quiz"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(quizData), // Encodage en JSON
      );
print('ddd ${response.statusCode} ${response.body}');
      // Traitement de la réponse du serveur
      if (response.statusCode == 201) {
        setState(() {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Succès',
            desc: 'Votre quiz a été créé !',
            onDismissCallback: (type) {
              Navigator.pop(context);
            },
            autoHide: const Duration(seconds: 2, milliseconds: 500),
          ).show();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Erreur',
            desc: 'Échec de la création du quiz. Veuillez vérifier les données et réessayer.',
            autoHide: const Duration(seconds: 2, milliseconds: 500),
          ).show();
        });
      }
    }
  }

}
