import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizzy/pages/home_page.dart';
import 'package:quizzy/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color darkColor = Colors.black;
  Color inputFillColor = const Color(0xfff4f8fa);
  Color inputBorderColor = const Color(0xffd0e2ea);
  Color textColor = const Color(0xff90a1ac);
  Color colors5 = Colors.black;
  Color colorsBlack = Colors.black;
  final radius = 10.0;
  bool isLoading = false;
  String errorMessage = "";
  // final Variable variable = Variable();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // void connexion() async {
  //   setState(() => isLoading = true);
  //   final response = await post(
  //     Uri.parse("${variable.apiUrl}/auth-user"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'email': emailController.text,
  //       'password': passwordController.text,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var body = jsonDecode(response.body);
  //
  //     setState(() {
  //       variable.saveApiKey(body['apiKey']);
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => SearchPage(apiKey: body['apiKey'])),(route) => false,);
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //       errorMessage = "Identifiants incorrects";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                  child: Image.asset("assets/images/logo.png", height: 250)),
              const SizedBox(height: 70),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Text('Email'),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  key: widget.key,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black87),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Entrer votre email',
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Poppins",
                                        color: textColor),
                                    filled: true,
                                    fillColor: inputFillColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                      borderSide:
                                          BorderSide(color: inputBorderColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                      borderSide: BorderSide(
                                          color: colors5.withOpacity(0.5)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                      borderSide:
                                          BorderSide(color: inputBorderColor),
                                    ),
                                    suffixIconColor:
                                        const Color.fromARGB(255, 41, 50, 65),
                                    suffixIcon: const Icon(
                                        Icons.alternate_email_rounded),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Veuillez entrer un email';
                                    }
                                    if (!value.contains('@')) {
                                      return '\u26A0 Adresse email invalide!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: Text('Mot de passe'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black87),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Entrer votre mot de passe',
                                hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Poppins",
                                    color: textColor),
                                filled: true,
                                fillColor: inputFillColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(radius),
                                  borderSide:
                                      BorderSide(color: inputBorderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(radius),
                                  borderSide: BorderSide(
                                      color: colors5.withOpacity(0.5)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(radius),
                                  borderSide:
                                      BorderSide(color: inputBorderColor),
                                ),
                                suffixIconColor:
                                    const Color.fromARGB(255, 41, 50, 65),
                                suffixIcon:
                                    const Icon(Icons.lock_outline_rounded),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Veuillez entrer un mot de passe';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       SizedBox(),
                    //       GestureDetector(
                    //           onTap: () {},
                    //           child: Text('Mot de passe oublié ?',
                    //               style: TextStyle(color: Colors.blue))),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 12),
                    errorMessage != ""
                        ? Text(errorMessage,
                            style: const TextStyle(color: Colors.red))
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.redAccent,
                            )
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                },));
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                disabledForegroundColor:
                                    Colors.red.withOpacity(0.38),
                                disabledBackgroundColor:
                                    Colors.red.withOpacity(0.12),
                                backgroundColor: Color.fromRGBO(16, 66, 148, 1),
                                shadowColor: Colors.grey.shade500,
                                elevation: 1,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.7,
                                    50),
                              ),
                              child: const Text(
                                "Se Connecter",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Vous n’avez pas de compte ? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
