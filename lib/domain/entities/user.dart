import 'package:equatable/equatable.dart';

enum UserRole {
  client,
  provider,
  admin,
}

enum Gender {
  female,
  male,
  other,
  preferNotToSay,
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final Gender? gender; // Para filtro de profissionais femininas
  final String? photoUrl;
  final DateTime createdAt;
  final bool isActive;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.gender,
    this.photoUrl,
    required this.createdAt,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        role,
        gender,
        photoUrl,
        createdAt,
        isActive,
      ];
}