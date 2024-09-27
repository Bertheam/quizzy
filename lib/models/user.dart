
class User {
  final int id;
  final String nom;
  final String prenom;
  final String email;
   String filiere;
   String classes;
  final String role;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    this.filiere = '',
    this.classes = '',
    required this.role
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['id'] ?? 0,
        nom: json['nom'] ?? '',
        prenom: json['prenom'] ?? '',
        email: json['email'] ?? '',
        filiere: json['filiere'] ?? '',
        classes: json['classes'] ?? '',
        role: json['role'] ?? ''
    );
  }



}