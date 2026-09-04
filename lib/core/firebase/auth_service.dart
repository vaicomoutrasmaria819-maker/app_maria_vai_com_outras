// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mariavai_services/domain/entities/user.dart' as domain;
//
// /// Autenticação própria com bcrypt.
// ///
// /// As senhas NÃO passam pelo provedor de email/senha do Firebase Auth.
// /// Em vez disso:
// /// 1. O app chama as Cloud Functions `registerUser`/`loginUser`.
// /// 2. Lá no servidor, a senha é hasheada/comparada com bcrypt contra o
// ///    valor salvo em `users_private/{uid}` (coleção bloqueada para
// ///    qualquer leitura vinda do cliente — ver firestore.rules).
// /// 3. Em caso de sucesso, a function devolve um Firebase Custom Token.
// /// 4. Aqui trocamos esse token por uma sessão real via
// ///    signInWithCustomToken(), o que mantém request.auth.uid válido nas
// ///    regras do Firestore normalmente.
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // Mesmo banco não-default usado em firestore_service.dart.
//   final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(
//     app: Firebase.app(),
//     databaseId: 'mariavaidb',
//   );
//
//   // Ajuste a região se você fez o deploy das functions em outra (o
//   // firebase.json/functions/index.js deste projeto usa
//   // 'southamerica-east1' por padrão).
//   final FirebaseFunctions _functions =
//       FirebaseFunctions.instanceFor(region: 'southamerica-east1');
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//
//   User? get currentUser => _auth.currentUser;
//
//   bool get isLoggedIn => currentUser != null;
//
//   /// Login com email e senha, verificados via bcrypt no servidor.
//   Future<domain.User> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     final callable = _functions.httpsCallable('loginUser');
//
//     late final HttpsCallableResult<Map<String, dynamic>> result;
//     try {
//       result = await callable.call<Map<String, dynamic>>({
//         'email': email,
//         'password': password,
//       });
//     } on FirebaseFunctionsException catch (e) {
//       throw AuthServiceException(_mapFunctionsError(e));
//     }
//
//     final token = result.data['token'] as String;
//     final credential = await _auth.signInWithCustomToken(token);
//
//     return _loadDomainUser(credential.user!.uid);
//   }
//
//   /// Cadastro com email e senha. [adminAccessCode] só é necessário quando
//   /// [role] é [domain.UserRole.admin] — a validação real acontece no
//   /// servidor (Cloud Functions config), nunca no app.
//   Future<domain.User> registerWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String name,
//     required String phone,
//     required domain.UserRole role,
//     String? adminAccessCode,
//   }) async {
//     final callable = _functions.httpsCallable('registerUser');
//
//     late final HttpsCallableResult<Map<String, dynamic>> result;
//     try {
//       result = await callable.call<Map<String, dynamic>>({
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'password': password,
//         'role': role.name,
//         if (adminAccessCode != null && adminAccessCode.isNotEmpty)
//           'adminAccessCode': adminAccessCode,
//       });
//     } on FirebaseFunctionsException catch (e) {
//       throw AuthServiceException(_mapFunctionsError(e));
//     }
//
//     final token = result.data['token'] as String;
//     final credential = await _auth.signInWithCustomToken(token);
//
//     // A Cloud Function já criou o documento em `users/{uid}` — não
//     // precisamos (nem devemos) escrever de novo pelo cliente.
//     return domain.User(
//       id: credential.user!.uid,
//       name: name,
//       email: email.trim().toLowerCase(),
//       phone: phone,
//       role: role,
//       createdAt: DateTime.now(),
//       isActive: true,
//     );
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
//
//   /// TODO: como não usamos o provedor de email/senha do Firebase Auth,
//   /// "esqueci minha senha" precisa de uma Cloud Function própria (gerar
//   /// código de verificação, enviar por email via algum serviço como
//   /// Resend/SendGrid, e uma tela para digitar o código + nova senha).
//   /// Ainda não implementado — me avise quando quiser montar esse fluxo.
//   Future<void> sendPasswordResetEmail(String email) async {
//     throw UnimplementedError(
//       'Reset de senha ainda não implementado para o fluxo de autenticação '
//       'próprio com bcrypt.',
//     );
//   }
//
//   Future<domain.User> _loadDomainUser(String uid) async {
//     final doc = await _firestore.collection('users').doc(uid).get();
//     final data = doc.data();
//
//     if (data == null) {
//       throw AuthServiceException('Perfil de usuário não encontrado.');
//     }
//
//     return domain.User(
//       id: uid,
//       name: data['name'] as String? ?? 'Usuário',
//       email: data['email'] as String? ?? '',
//       phone: data['phone'] as String? ?? '',
//       role: domain.UserRole.values.byName(
//         data['role'] as String? ?? 'client',
//       ),
//       createdAt:
//           (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       isActive: true,
//     );
//   }
//
//   String _mapFunctionsError(FirebaseFunctionsException e) {
//     switch (e.code) {
//       case 'unauthenticated':
//         return 'Email ou senha inválidos.';
//       case 'already-exists':
//         return 'Este email já está cadastrado.';
//       case 'permission-denied':
//         return e.message ?? 'Código de acesso administrativo inválido.';
//       case 'resource-exhausted':
//         return e.message ?? 'Muitas tentativas. Tente novamente mais tarde.';
//       case 'invalid-argument':
//         return e.message ?? 'Dados inválidos.';
//       default:
//         return e.message ?? 'Erro inesperado. Tente novamente.';
//     }
//   }
// }
//
// class AuthServiceException implements Exception {
//   final String message;
//   AuthServiceException(this.message);
//
//   @override
//   String toString() => message;
// }
