import 'package:equatable/equatable.dart';

enum UserRole {
  client,
  provider,
  admin,
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String? photoUrl;
  final DateTime createdAt;
  final bool isActive;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
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
        photoUrl,
        createdAt,
        isActive,
      ];
}