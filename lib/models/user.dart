import 'dart:ffi';

class User {
  final int id;
  final String documentId;
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final Float height;
  final Float weight;
  final String? name;

  User({
    required this.id,
    required this.documentId,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.height,
    required this.weight,
    required this.name,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      documentId: json['documentId'],
      username: json['username'],
      email: json['email'],
      provider: json['provider'],
      confirmed: json['confirmed'],
      blocked: json['blocked'],
      height: json['height'],
      weight: json['weight'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
      name: json['name'],
      
    );
  }
}
