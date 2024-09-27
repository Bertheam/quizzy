
import 'package:quizzy/models/question.dart';

class Quiz {
  final int id;
  final String nom;
  final String description;
  final String temps;
  String theme ;
  final int user;
  final String date;
  List<Question> questions;

  Quiz({
    required this.id,
    required this.nom,
    required this.description,
    this.temps = '0',
    required this.user,
    this.theme = 'default',
    required this.date,
    required this.questions
  });

  factory Quiz.fromJson(Map<String, dynamic> json){
    return Quiz(
        id: json['id'] ?? 0,
        nom: json['nom'] ?? '',
        description: json['description'] ?? '',
        theme: json['theme'] ?? '',
        temps: json['temps'] ?? '',
        user: json['users_id'] ?? 0,
        date: json['date'] ?? '',
        questions: json['questions'] ?? []
    );
  }
}