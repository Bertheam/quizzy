
class Question {
  final String id;
  final String enonce;
  final String theme;
  final String quiz;

  Question({
    required this.id,
    required this.enonce,
    required this.theme,
    required this.quiz
  });

  factory Question.fromJson(Map<String, dynamic> json){
    return Question(
        id: json['id'] ?? '',
        enonce: json['enonce'] ?? '',
        theme: json['theme'] ?? '',
        quiz: json['quiz'] ?? ''
    );
  }



}