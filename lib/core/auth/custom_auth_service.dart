import 'package:mariavai_services/core/auth/password_service.dart';
import 'package:mariavai_services/core/firebase/firestore_service.dart';
import 'package:mariavai_services/domain/entities/user.dart' as domain;

class CustomAuthService {
  final _firestoreService = FirestoreService();
  final _passwordService = PasswordService();

  // Registrar novo usuário
  Future<domain.User> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required domain.UserRole role,
    domain.Gender? gender,
  }) async {
    // Verificar se email já existe
    final existingUser = await _firestoreService.getUserByEmail(email);
    if (existingUser != null) {
      throw Exception('Email já cadastrado');
    }

    // Criptografar senha
    final hashedPassword = _passwordService.hashPassword(password);

    // Criar documento do usuário no Firestore
    final user = domain.User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      role: role,
      gender: gender,
      photoUrl: null,
      createdAt: DateTime.now(),
      isActive: true,
    );

    // Armazenar usuário e senha (separadamente) no Firestore
    await _firestoreService.createUser(user);
    await _firestoreService.createUserWithPassword(user.id, hashedPassword);

    return user;
  }

  // Login com email e senha
  Future<domain.User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Buscar usuário por email
    final user = await _firestoreService.getUserByEmail(email);
    
    if (user == null) {
      throw Exception('Usuário não encontrado');
    }

    if (!user.isActive) {
      throw Exception('Usuário desativado');
    }

    // Verificar senha (busca senha criptografada separadamente)
    final isValidPassword = await _firestoreService.verifyUserPassword(
      user.id, 
      password
    );

    if (!isValidPassword) {
      throw Exception('Senha incorreta');
    }

    return user;
  }

  // Logout (remover sessão local)
  Future<void> signOut() async {
    // Em produção, limpar tokens de sessão do Firestore
    // Por enquanto, apenas retorna sucesso
    await Future.delayed(const Duration(milliseconds: 100));
  }

  // Resetar senha (gerar nova senha temporária)
  Future<String> resetPassword(String email) async {
    final user = await _firestoreService.getUserByEmail(email);
    
    if (user == null) {
      throw Exception('Usuário não encontrado');
    }

    // Gerar nova senha temporária
    final tempPassword = _generateTempPassword();
    final hashedPassword = _passwordService.hashPassword(tempPassword);

    // Atualizar senha no Firestore
    await _firestoreService.updateUserPassword(user.id, hashedPassword);

    // Em produção, enviar email com nova senha
    // Por enquanto, retorna a senha para teste
    return tempPassword;
  }

  // Atualizar senha
  Future<void> updatePassword(
    String userId, 
    String currentPassword, 
    String newPassword
  ) async {
    // Verificar senha atual
    final isValid = await _firestoreService.verifyUserPassword(userId, currentPassword);
    
    if (!isValid) {
      throw Exception('Senha atual incorreta');
    }

    // Criptografar nova senha
    final hashedPassword = _passwordService.hashPassword(newPassword);

    // Atualizar no Firestore
    await _firestoreService.updateUserPassword(userId, hashedPassword);
  }

  // Gerar senha temporária aleatória
  String _generateTempPassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%&*';
    final random = DateTime.now().millisecondsSinceEpoch;
    final password = StringBuffer();
    
    for (int i = 0; i < 12; i++) {
      password.write(chars[random % chars.length]);
    }
    
    return password.toString();
  }
}