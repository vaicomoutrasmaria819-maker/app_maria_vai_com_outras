import 'package:firebase_auth/firebase_auth.dart';
import 'package:mariavai_services/domain/entities/user.dart' as domain;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream de autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Usuário atual
  User? get currentUser => _auth.currentUser;

  // Login com email e senha
  Future<domain.User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _mapFirebaseUserToDomainUser(credential.user!);
  }

  // Registro com email e senha
  Future<domain.User> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required domain.UserRole role,
  }) async {
    final UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Atualizar perfil do usuário
    await credential.user?.updateDisplayName(name);

    // Criar documento do usuário no Firestore
    // Isso será feito no UserService

    return _mapFirebaseUserToDomainUser(credential.user!, name: name, phone: phone, role: role);
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Resetar senha
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Mapear usuário do Firebase para domínio
  domain.User _mapFirebaseUserToDomainUser(
    User firebaseUser, {
    String? name,
    String? phone,
    domain.UserRole? role,
  }) {
    return domain.User(
      id: firebaseUser.uid,
      name: name ?? firebaseUser.displayName ?? 'Usuário',
      email: firebaseUser.email ?? '',
      phone: phone ?? '',
      role: role ?? domain.UserRole.client,
      photoUrl: firebaseUser.photoURL,
      createdAt: DateTime.now(),
      isActive: true,
    );
  }

  // Verificar se está logado
  bool get isLoggedIn => currentUser != null;
}