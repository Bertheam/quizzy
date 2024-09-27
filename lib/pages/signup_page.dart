import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart';
import 'package:quizzy/components/custom_textfield.dart';
import 'package:quizzy/global/variable.dart';
import 'package:quizzy/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  Color darkColor = Colors.black;
  Color inputFillColor = const Color(0xfff4f8fa);
  Color inputBorderColor = const Color(0xffd0e2ea);
  Color textColor = const Color(0xff90a1ac);
  Color colors5 = Colors.black;
  Color colorsBlack = Colors.black;
  final radius = 10.0;
  bool isLoading = false;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  bool isOnline = false;
  bool isProfesseur = false;
  String errorMessage = "";
  final Variable variable = Variable();
  String selectedValueRole = 'etudiant';
  String selectedValueFiliere = 'IG1';

  var roleItems = ['etudiant', 'professeur'];
  var filiereItems = ['IG1', 'IG2','PDI'];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController filiereController = TextEditingController();
  TextEditingController classeController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  void inscription() async {
    setState(() => isLoading = true);

    // Vérification du mot de passe
    String password = passwordController.text;
    bool passwordValide = verifierMotDePasse(password);

    if (!passwordValide) {
      setState(() {
        isLoading = false;
        errorMessage = "Le mot de passe doit contenir au moins 14 caractères, un caractère spécial et un chiffre.";
      });
      return; // Sort de la fonction si le mot de passe n'est pas valide
    }

    final response = await post(
      Uri.parse("${variable.apiUrl}/create-user"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
        'role': selectedValueRole,
        'profession': professionController.text,
        'filiere': selectedValueFiliere,
        'classes': selectedValueFiliere,
        'nom': nomController.text,
        'prenom': prenomController.text
      }),
    );
print(' ddd ${response.body}');
    if (response.statusCode == 201) {
      // var body = jsonDecode(response.body);

      setState(() {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Succès',
            desc: 'Votre compte a été crée !',
            onDismissCallback: (type) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
              );
            },
            autoHide: const Duration(seconds: 2, milliseconds: 500)

          // btnOkOnPress: () {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => const LoginPage()),
          //         (route) => false,
          //   );
          // },
        ).show();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Erreur lors de la création";
      });
    }
  }
  // Fonction pour vérifier le mot de passe
  bool verifierMotDePasse(String password) {
    final regex = RegExp(r'^(?=.*[0-9])(?=.*[!@#\$&*~])(?=.{14,})');
    return regex.hasMatch(password);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                  child: Image.asset("assets/images/logo.png",
                      height: 250)),
              const SizedBox(height: 70),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 190,
                                height: 57,
                                child: CustomTextfield(
                                    placeholder: 'Prénom',
                                    controller: prenomController,
                                    keyboardType: TextInputType.text),
                              ),
                              SizedBox(
                                width: 190,
                                height: 57,
                                child: CustomTextfield(
                                    placeholder: 'Nom',
                                    controller: nomController,
                                    keyboardType: TextInputType.text),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 190,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12)),
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                                    border: InputBorder.none,
                                  ),
                                  value: selectedValueRole,
                                  items: roleItems
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Veuillez sélectionner un role.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    selectedValueRole = value.toString();
                                    setState(() {
                                      if (selectedValueRole == 'professeur') {
                                        isProfesseur = true;
                                      } else {
                                        isProfesseur = false;
                                      }
                                    });
                                  },
                                  onSaved: (value) {
                                    selectedValueRole = value.toString();
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),

                              Container(
                                width: 190,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12)),
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                                    border: InputBorder.none,
                                  ),
                                  value: selectedValueFiliere,
                                  items: filiereItems
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Veuillez sélectionner....';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    selectedValueFiliere = value.toString();

                                  },
                                  onSaved: (value) {
                                    selectedValueFiliere = value.toString();
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    if(isProfesseur)
                      SizedBox(
                        height: 57,
                        child: CustomTextfield(
                            placeholder: 'Profession',
                            controller: professionController,
                            icon: Icon(Icons.person),
                            keyboardType: TextInputType.text),
                      ),
                      const SizedBox(height: 10),
                    SizedBox(
                      height: 57,
                      child: CustomTextfield(
                          placeholder: 'Email',
                          controller: emailController,
                          icon: Icon(Icons.alternate_email_rounded),
                          keyboardType: TextInputType.emailAddress),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 57,
                      child: CustomTextfield(
                          placeholder: 'Password',
                          controller: passwordController,
                          icon: Icon(Icons.lock_rounded),
                          setObscure: true),
                    ),
                    errorMessage != ""
                        ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                          child: Text(errorMessage,
                          style: const TextStyle(color: Colors.blue)),
                        )
                        : const SizedBox(),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.blue,
                      )
                          : ElevatedButton(
                        onPressed: inscription,
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
                          "S'inscrire",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
