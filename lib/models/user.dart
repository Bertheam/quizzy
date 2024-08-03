
class User {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String role;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.role
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['id'] ?? '',
        nom: json['nom'] ?? '',
        prenom: json['prenom'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        role: json['role'] ?? ''
    );
  }



}