import 'package:bcrypt/bcrypt.dart';

class PasswordService {
  // Criptografar senha
  static String hashPassword(String password) {
    // Gera um hash bcrypt com salt automático
    // O salt é incluído no hash resultante
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  // Verificar senha
  static bool verifyPassword(String password, String hashedPassword) {
    try {
      return BCrypt.checkpw(password, hashedPassword);
    } catch (e) {
      print('Erro ao verificar senha: $e');
      return false;
    }
  }

  // Gerar salt aleatório (se necessário)
  static String generateSalt() {
    return BCrypt.gensalt();
  }
}