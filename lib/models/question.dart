
import 'package:flutter/cupertino.dart';

class Question {
  final int id;
  TextEditingController enonceController;
  List<TextEditingController> reponsesControllers;
  int bonneReponseIndex;

  Question({
    required this.id,
    required this.enonceController,
    required this.reponsesControllers,
    required this.bonneReponseIndex
  });

  factory Question.fromJson(Map<String, dynamic> json){
    return Question(
        id: json['id'] ?? 0,
        enonceController: json['enonceController'] ?? '',
        reponsesControllers: json['reponsesControllers'] ?? '',
        bonneReponseIndex: json['bonneReponseIndex'] ?? ''
    );
  }



}