import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quizzy/components/carousel/build_info.dart';
import 'package:quizzy/components/categorie_card.dart';
import 'package:quizzy/components/quiz_tile.dart';
import 'package:quizzy/global/variable.dart';
import 'package:quizzy/models/quiz.dart';
import 'package:quizzy/models/user.dart';
import 'package:quizzy/pages/login_page.dart';
import 'package:quizzy/pages/quiz/answer_quiz.dart';

class AccueilPage extends StatefulWidget {
  User user;
  AccueilPage({super.key, required this.user});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final controllerTextEditing = TextEditingController();
  List categories = [
    CategorieCard(
      gradient: LinearGradient(
        colors: [Colors.indigoAccent, Colors.blue, Colors.grey],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icon(
        Icons.laptop_chromebook,
        color: Colors.grey[700],
        size: 30,
      ),
      libelle: "Informatique",
    ),
    CategorieCard(
        gradient: LinearGradient(
        colors: [Colors.blueAccent, Colors.blue, Colors.pinkAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        ),
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Droit"),
    CategorieCard(
        gradient: LinearGradient(
        colors: [Colors.cyan, Colors.teal, Colors.grey],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        ),
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Marketing"),
    CategorieCard(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.red, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Ressource Humaine"),
    CategorieCard(
        gradient: LinearGradient(
    colors: [Colors.blue, Colors.red, Colors.green],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  ),
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Administration entreprise"),
  ];
  List<Quiz> quizzes = [];
  bool isLoading = false;
  var isDeviceConnected = false;
  bool isOnline = false;
  Variable variable = Variable();

  Future<List<Quiz>> getQuiz() async {
    setState(() => isLoading = true);
    // var apiKey = variable.getApiKey();
    final res = await get(
      Uri.parse("${variable.apiUrl}/quizzes"),
      headers: <String, String>{
        // 'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
      },
    );
    print('ddd ${res.body}');
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      setState(() {
        isLoading = false;
        quizzes.addAll(body
            .map(
              (dynamic item) => Quiz.fromJson(item),
        )
            .toList());
      });

      setState(() {
        isLoading = false;
      });

      return quizzes;
    } else {
      throw " ++++++++++++++++++++++++++ Unable to retrieve quiz etudiant";
    }
  }

  @override
  void initState() {
    super.initState();
    // getQuiz();
  }
  @override
  Widget build(BuildContext context) {
    print(categories.length);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // toolbarHeight: 100,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Row(
            children: [
              SizedBox(width: 5,),
              GestureDetector(
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Déconnexion',
                    desc: 'Appuyer sur Ok pour vous déconnecter',
                    btnOkOnPress: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                            (route) => false,
                      );
                    },
                    btnCancelOnPress: () {},
                  ).show();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/person_icon.png',color: Colors.white,),
                ),
              ),
            ],
          ),
        ),
        title: Text("${widget.user.prenom} ${widget.user.nom}", style: TextStyle(color: Colors.white),),
        actions: [
          
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
              child: Icon(Icons.notifications, color: Colors.black)
          ),
          SizedBox(width: 16),
        ],

      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 18),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                            child: TextField(
                          controller: controllerTextEditing,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.grey.shade600,
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 10),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Rechercher',
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                          ),
                          // onChanged: filterNumero,
                        )),
                      ),
                    ),
                    BuildInfo(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.4,
                  mainAxisSpacing: 10),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              primary: false,
              itemCount: 4,
              itemBuilder: (context, index) {
                return categories[index];
              },
            ),
            categories.length > 4
                ? GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      'Voir plus',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                : SizedBox(),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount:quizzes.length,
                itemBuilder: (context, index) {
                  var quiz = quizzes[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerQuiz(),)),
                      child: QuizTile(title:  quiz.nom, description: quiz.description,));
              },
              )
          ],
        )),
      ),
    );
  }
}
