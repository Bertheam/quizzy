import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizzy/models/quiz.dart';
import 'package:quizzy/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String apiUrl  = "https://7065-41-73-105-228.ngrok-free.app/api";
  String baseUrl = "https://7065-41-73-105-228.ngrok-free.app/";

//check identifiant
  Future<Map<String, dynamic>> authCheckMatricule(String email, String password,
      BuildContext context) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth-check-identifiant'),
      body: {
        'email': email,
        'password': password
      },
    );
    await handleApiResponse(response, context);
    print('fff ${jsonDecode(response.body)}');


    if (response.statusCode == 200) {
      print("Fetching API=${response.body}");
      return jsonDecode(response.body);
    } else {
      if (jsonDecode(response.body)['message'] != null) {
        throw jsonDecode(response.body)['message'];
      }
      throw jsonDecode(response.body)['error'];
    }
  }

//check code SMS
  Future<String> authCheckEmailCode(String email, String codePin,
      BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth-check-codePin'),
        body: {
          'email': email,
          'code_pin': codePin,
        },
      );

      await handleApiResponse(response, context);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        if (result.containsKey('ApiKey')) {
          return "codePinValide";
        } else {
          return "codePinValidExpire";
        }
      } else {
        if (response.statusCode == 410) {
          return 'codePinExpire';
        } else {
          return "codePinIncorrect";
        }
      }
    } catch (e) {
      throw Exception('Code Pin Invalide: $e');
    }
  }

//  Cette méthode récupère la clé API en envoyant une requête POST à l'API avec
//l'email et le mot de passe en tant que paramètres.
//Si la réponse est un code de statut 200, elle extrait la clé API
//de la réponse et la renvoie. Sinon, elle retourne "Apikey non trouvé"
  Future<String> retrievedAPIKEY(String email, String password,
      BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth-check-identifiant'),
        body: {
          'email': email,
          'password': password,
        },
      );
      await handleApiResponse(response, context);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        return result["ApiKey"];
      } else {
        return "Apikey non trouve";
      }
    } catch (e) {
      throw Exception('Code Pin Invalide: $e');
    }
  }

//Recupere l'api Key
  Future<String?> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getKeys());
    return prefs.getString('apiKey');
  }

//Supprime l'api Key
  Future<void> removeApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('apiKey');
  }

//Obtenir tous les informations sur un adhérant
  Future<Map<String, dynamic>> getUserInfo(BuildContext context) async {
    try {
      final apiKey = await getApiKey();

      if (apiKey == null) {
        throw Exception('Clé API non trouvée dans le local storage');
      }

      print('Clé API utilisée pour la requête : $apiKey');

      final response = await http.get(
        Uri.parse('$baseUrl/adherent-info'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      );
      await handleApiResponse(response, context);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Erreur API: ${response.statusCode}, ${response.body}');
        throw Exception(
            'Erreur lors de la récupération des informations de l\'adhérent');
      }
    } catch (e) {
      print(
          'Erreur lors de la récupération des informations de l\'adhérent: $e');
      throw Exception(
          'Erreur lors de la récupération des informations de l\'adhérent');
    }
  }

  Future<List<Quiz>> getAllQuiz(BuildContext context) async {
    final apiKey = await getApiKey();
    final response = await http.get(
      Uri.parse('$apiUrl/quizzes'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    await handleApiResponse(response, context);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((quiz) => Quiz.fromJson(quiz))
          .toList();
    } else {
      throw Exception('erreur lors de la recuperation des quiz etudiants');
    }
  }

  Future<List<Quiz>> getAllQuizProfesseur(BuildContext context, int userId) async {
    final apiKey = await getApiKey();
    final response = await http.post(
      Uri.parse('$apiUrl/quizzes'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: {
        'user_id': userId,
      },
    );
    await handleApiResponse(response, context);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((quiz) => Quiz.fromJson(quiz))
          .toList();
    } else {
      throw Exception('erreur lors de la recuperation des quiz etudiants');
    }
  }

//une fonction qui li le status de l'api pour supprimer lapi Key stocké dans
//le local storage et redirige vers la page login

  Future<void> handleApiResponse(http.Response response,
      BuildContext context) async {
    if (response.statusCode == 401) {
      await removeApiKey();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}