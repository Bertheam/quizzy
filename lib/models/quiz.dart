
class Quiz {
  final String id;
  final String nom;
  final String description;
  final String temps;
  final String user;
  final String date;

  Quiz({
    required this.id,
    required this.nom,
    required this.description,
    required this.temps,
    required this.user,
    required this.date
  });

  factory Quiz.fromJson(Map<String, dynamic> json){
    return Quiz(
        id: json['id'] ?? '',
        nom: json['nom'] ?? '',
        description: json['description'] ?? '',
        temps: json['temps'] ?? '',
        user: json['user'] ?? '',
        date: json['date'] ?? ''
    );
  }



}