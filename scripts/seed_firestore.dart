import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

/// Script para popular o Firestore com dados de teste
/// Uso: dart scripts/seed_firestore.dart
/// 
/// Este script cria as coleções e documentos necessários para o app
/// funcionar corretamente no banco de dados mariavaidb.

Future<void> main() async {
  print('🔥 Iniciando seed do Firestore...');
  
  try {
    // Inicializar Firebase
    await Firebase.initializeApp();
    print('✅ Firebase inicializado');
    
    // Conectar ao banco não-default
    final firestore = FirebaseFirestore.instanceFor(
      databaseId: 'mariavaidb',
    );
    print('✅ Conectado ao banco: mariavaidb');
    
    // ===== CRIAR USUÁRIOS =====
    print('\n📝 Criando usuários de teste...');
    
    final users = [
      {
        'name': 'Maria Silva',
        'email': 'cliente@teste.com',
        'phone': '(11) 99999-1001',
        'role': 'client',
        'photoUrl': null,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      },
      {
        'name': 'Ana Costa',
        'email': 'prestadora@teste.com',
        'phone': '(11) 99999-1002',
        'role': 'provider',
        'photoUrl': null,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      },
      {
        'name': 'Juliana Santos',
        'email': 'prestadora2@teste.com',
        'phone': '(11) 99999-1004',
        'role': 'provider',
        'photoUrl': null,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      },
      {
        'name': 'Administrador',
        'email': 'admin@teste.com',
        'phone': '(11) 99999-1003',
        'role': 'admin',
        'photoUrl': null,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      },
    ];
    
    final userUids = <String>[];
    
    for (final user in users) {
      final docRef = await firestore.collection('users').add(user);
      userUids.add(docRef.id);
      print('   ✅ Usuário criado: ${user['email']} (UID: ${docRef.id})');
    }
    
    // ===== CRIAR ÍNDICE DE EMAIL =====
    print('\n📝 Criando índice de email...');
    
    for (int i = 0; i < users.length; i++) {
      final email = users[i]['email'] as String;
      final uid = userUids[i];
      
      await firestore.collection('email_index').doc(email).set({
        'email': email,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('   ✅ Email index criado: $email → $uid');
    }
    
    // ===== CRIAR SERVIÇOS DE TESTE =====
    print('\n📝 Criando serviços de teste...');
    
    final services = [
      {
        'clientId': userUids[0], // Maria Silva (cliente)
        'providerId': '',
        'title': 'Limpeza residencial completa',
        'description': 'Limpeza completa de 3 quartos, sala, cozinha e 2 banheiros. Inclui produtos de limpeza.',
        'price': 150.00,
        'status': 'pending',
        'address': 'Rua das Flores, 123 - Jardim Primavera',
        'createdAt': FieldValue.serverTimestamp(),
        'scheduledDate': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
        'completedAt': null,
        'commissionRate': 0.20,
        'clientNotes': 'Categoria: Limpeza',
      },
      {
        'clientId': userUids[0], // Maria Silva (cliente)
        'providerId': '',
        'title': 'Pintura de parede',
        'description': 'Pintura de sala de estar, cor branca. Área aproximada: 30m².',
        'price': 800.00,
        'status': 'pending',
        'address': 'Rua das Flores, 123 - Jardim Primavera',
        'createdAt': FieldValue.serverTimestamp(),
        'scheduledDate': DateTime.now().add(const Duration(days: 5)).toIso8601String(),
        'completedAt': null,
        'commissionRate': 0.20,
        'clientNotes': 'Categoria: Pintura',
      },
    ];
    
    final serviceIds = <String>[];
    
    for (final service in services) {
      final docRef = await firestore.collection('services').add(service);
      serviceIds.add(docRef.id);
      print('   ✅ Serviço criado: ${service['title']} (ID: ${docRef.id})');
    }
    
    // ===== CRIAR PAGAMENTOS DE TESTE =====
    print('\n📝 Criando pagamentos de teste...');
    
    final payments = [
      {
        'serviceId': serviceIds[0],
        'amount': 150.00,
        'commissionAmount': 30.00,
        'providerAmount': 120.00,
        'status': 'completed',
        'paymentMethod': 'pix',
        'transactionId': 'pix123456789',
        'createdAt': FieldValue.serverTimestamp(),
        'completedAt': FieldValue.serverTimestamp(),
      },
    ];
    
    for (final payment in payments) {
      await firestore.collection('payments').add(payment);
      print('   ✅ Pagamento criado: R\$ ${payment['amount']}');
    }
    
    // ===== CRIAR ALERTA DE PÂNICO DE TESTE =====
    print('\n📝 Criando alerta de pânico de teste...');
    
    final panicAlert = {
      'userId': userUids[0], // Maria Silva
      'latitude': -23.5505,
      'longitude': -46.6333,
      'status': 'resolved',
      'createdAt': FieldValue.serverTimestamp(),
      'resolvedAt': FieldValue.serverTimestamp(),
      'emergencyContact': '190',
    };
    
    await firestore.collection('panic_alerts').add(panicAlert);
    print('   ✅ Alerta de pânico criado');
    
    print('\n' + '=' * 50);
    print('✅ Seed concluído com sucesso!');
    print('=' * 50);
    print('\n📱 Credenciais de Login:');
    print('👤 Cliente: cliente@teste.com / (definir via Cloud Function)');
    print('👩 Prestadora: prestadora@teste.com / (definir via Cloud Function)');
    print('👩 Prestadora 2: prestadora2@teste.com / (definir via Cloud Function)');
    print('👨‍💼 Admin: admin@teste.com / (definir via Cloud Function)');
    print('\n⚠️  IMPORTANTE: As senhas precisam ser definidas via Cloud Functions!');
    print('   Use o script seed_test_users.js no diretório functions/');
    
  } catch (e) {
    print('❌ Erro durante o seed: $e');
    rethrow;
  }
}