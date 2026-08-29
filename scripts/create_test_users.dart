import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/auth.dart' as auth;
import 'package:firebase_admin/src/firestore.dart' as firestore;

/// Script para criar usuários de teste no Firebase
/// Uso: dart scripts/create_test_users.dart <service-account.json>
void main(List<String> args) async {
  if (args.isEmpty) {
    print('Uso: dart create_test_users.dart <service-account.json>');
    print('Obtenha a service account em: Firebase Console → Project Settings → Service Accounts');
    return;
  }

  final serviceAccountPath = args[0];

  try {
    // Inicializar Firebase Admin SDK
    final credentials = 
        ServiceAccountCredentials.fromServiceAccountFile(serviceAccountPath);
    await FirebaseAdmin.initializeApp(credentials);

    final db = firestore.Firestore.instance;

    print('🔥 Criando usuários de teste no Firebase...');
    print('=' * 50);
    print('');

    // Dados dos usuários de teste
    final testUsers = [
      {
        'email': 'cliente@teste.com',
        'password': 'cliente123',
        'name': 'Maria Silva',
        'phone': '(11) 99999-1001',
        'role': 'client',
        'gender': null,
      },
      {
        'email': 'prestadora@teste.com',
        'password': 'prestadora123',
        'name': 'Ana Costa',
        'phone': '(11) 99999-1002',
        'role': 'provider',
        'gender': 'female',
      },
      {
        'email': 'prestadora2@teste.com',
        'password': 'prestadora123',
        'name': 'Juliana Santos',
        'phone': '(11) 99999-1004',
        'role': 'provider',
        'gender': 'female',
      },
      {
        'email': 'admin@teste.com',
        'password': 'admin123',
        'name': 'Administrador',
        'phone': '(11) 99999-1003',
        'role': 'admin',
        'gender': null,
      },
    ];

    int createdCount = 0;

    for (final userData in testUsers) {
      try {
        // Criar usuário no Authentication
        final userRecord = await auth.Auth.instance.createUser(
          email: userData['email'] as String,
          password: userData['password'] as String,
          displayName: userData['name'] as String,
        );

        // Criar documento no Firestore
        final userDoc = db.collection('users').doc(userRecord.uid);
        final userDataMap = {
          'name': userData['name'],
          'email': userData['email'],
          'phone': userData['phone'],
          'role': userData['role'],
          'photoUrl': null,
          'isActive': true,
          'createdAt': firestore.FieldValue.serverTimestamp(),
        };

        if (userData['gender'] != null) {
          userDataMap['gender'] = userData['gender'];
        }

        await userDoc.set(userDataMap);

        print('✅ Usuário criado: ${userData['email']}');
        print('   Nome: ${userData['name']}');
        print('   Papel: ${userData['role']}');
        print('   UID: ${userRecord.uid}');
        print('');
        createdCount++;
      } catch (e) {
        print('❌ Erro ao criar usuário ${userData['email']}: $e');
        print('');
      }
    }

    print('=' * 50);
    print('✅ $createdCount usuários de teste criados com sucesso!');
    print('');
    print('📱 Credenciais de Login:');
    print('👤 Cliente: cliente@teste.com / cliente123');
    print('👩 Prestadora: prestadora@teste.com / prestadora123');
    print('👩 Prestadora 2: prestadora2@teste.com / prestadora123');
    print('👨‍💼 Admin: admin@teste.com / admin123');
    print('🔑 Código Admin: MARIAVAI-ADMIN-2026');

    await FirebaseAdmin.deleteApp();
  } catch (e) {
    print('❌ Erro: $e');
  }
}