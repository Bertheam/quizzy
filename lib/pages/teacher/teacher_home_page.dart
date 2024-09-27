import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quizzy/global/variable.dart';
import 'package:quizzy/models/quiz.dart';
import 'package:quizzy/models/user.dart';
import 'package:quizzy/pages/login_page.dart';
import 'package:quizzy/pages/profil_page.dart';
import 'package:quizzy/pages/quiz/new_quiz.dart';

class TeacherHomePage extends StatefulWidget {
  User user;
  TeacherHomePage({super.key, required this.user});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  List<Quiz> quizzes = [];
  bool isLoading = false;
  var isDeviceConnected = false;
  bool isOnline = false;
  Variable variable = Variable();

  Future<List<Quiz>> getQuiz() async {
    setState(() => isLoading = true);
    // var apiKey = variable.getApiKey();
    var authUserId = await variable.getAuthUserId();

    final res = await post(
      Uri.parse("${variable.apiUrl}/professor/quizzes"),
      headers: <String, String>{
        // 'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
      },
      body: {
        'id' : authUserId?.toString()
      }
    );
    print(res.body);
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
      throw " ++++++++++++++++++++++++++ Unable to retrieve quiz prof.";
    }
  }

  @override
  void initState() {
    super.initState();
    getQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
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
            const SizedBox(width: 10),
            Text(
              "${widget.user.prenom} ${widget.user.nom}",
              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.manage_accounts_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilPage()));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            onRefresh: () {
              quizzes.clear();

              return getQuiz();
            },
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Créer un nouveau quiz, pour vos étudiants',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewQuiz(),));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(16, 66, 148, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('Commencer',style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/images/carousel_img.jpg',
                            width: 190,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Vos quiz',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Voir tout',style: TextStyle(color: Colors.blue),),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isLoading
                    ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                    backgroundColor: Colors.grey.shade200,
                  ),
                )
                    : quizzes.isNotEmpty ? ListView.builder(
                  itemCount: quizzes.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    var quiz = quizzes[index];
                    return GestureDetector(
                      onTap: () {},
                      child: _buildQuizOption(quiz.nom, quiz.description),
                    );
                  },
                ) : const Center(
                  child: Text("Pas de quiz créé pour le moment !"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizOption(
      String name, String description) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      leading:  Image.asset('assets/images/graduation-cap.jpg'),
      title: Text(name),
      trailing: Text(description),
    );
  }
}
