/**
 * Script para popular o Firestore com dados de teste
 * Uso: node scripts/seed_firestore.js <service-account.json>
 * 
 * Este script cria as coleções e documentos necessários para o app
 * funcionar corretamente no banco de dados mariavaidb.
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

if (process.argv.length < 3) {
  console.log('Uso: node seed_firestore.js <service-account.json>');
  console.log('Obtenha a service account em: Firebase Console → Project Settings → Service Accounts');
  process.exit(1);
}

const serviceAccountPath = process.argv[2];

async function main() {
  try {
    // Ler o arquivo JSON da service account
    const serviceAccountPathResolved = path.resolve(serviceAccountPath);
    const serviceAccountContent = fs.readFileSync(serviceAccountPathResolved, 'utf8');
    const serviceAccount = JSON.parse(serviceAccountContent);
    
    // Inicializar Firebase Admin SDK
    // Usando o banco padrão '(default)'
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
    });

    const db = admin.firestore();
    
    console.log('🔥 Iniciando seed do Firestore...');
    console.log('✅ Firebase inicializado');
    console.log('✅ Conectado ao banco: (default)');
    
    // ===== CRIAR USUÁRIOS =====
    console.log('\n📝 Criando usuários de teste...');
    
    const users = [
      {
        name: 'Maria Silva',
        email: 'cliente@teste.com',
        phone: '(11) 99999-1001',
        role: 'client',
        photoUrl: null,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        isActive: true
      },
      {
        name: 'Ana Costa',
        email: 'prestadora@teste.com',
        phone: '(11) 99999-1002',
        role: 'provider',
        photoUrl: null,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        isActive: true
      },
      {
        name: 'Juliana Santos',
        email: 'prestadora2@teste.com',
        phone: '(11) 99999-1004',
        role: 'provider',
        photoUrl: null,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        isActive: true
      },
      {
        name: 'Administrador',
        email: 'admin@teste.com',
        phone: '(11) 99999-1003',
        role: 'admin',
        photoUrl: null,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        isActive: true
      }
    ];
    
    const userUids = [];
    
    for (const user of users) {
      const docRef = await db.collection('users').add(user);
      userUids.push(docRef.id);
      console.log(`   ✅ Usuário criado: ${user.email} (UID: ${docRef.id})`);
    }
    
    // ===== CRIAR ÍNDICE DE EMAIL =====
    console.log('\n📝 Criando índice de email...');
    
    for (let i = 0; i < users.length; i++) {
      const email = users[i].email;
      const uid = userUids[i];
      
      await db.collection('email_index').doc(email).set({
        email: email,
        uid: uid,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      });
      console.log(`   ✅ Email index criado: ${email} → ${uid}`);
    }
    
    // ===== CRIAR SERVIÇOS DE TESTE =====
    console.log('\n📝 Criando serviços de teste...');
    
    const services = [
      {
        clientId: userUids[0], // Maria Silva (cliente)
        providerId: '',
        title: 'Limpeza residencial completa',
        description: 'Limpeza completa de 3 quartos, sala, cozinha e 2 banheiros. Inclui produtos de limpeza.',
        price: 150.00,
        status: 'pending',
        address: 'Rua das Flores, 123 - Jardim Primavera',
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        scheduledDate: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000).toISOString(),
        completedAt: null,
        commissionRate: 0.20,
        clientNotes: 'Categoria: Limpeza'
      },
      {
        clientId: userUids[0], // Maria Silva (cliente)
        providerId: '',
        title: 'Pintura de parede',
        description: 'Pintura de sala de estar, cor branca. Área aproximada: 30m².',
        price: 800.00,
        status: 'pending',
        address: 'Rua das Flores, 123 - Jardim Primavera',
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        scheduledDate: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000).toISOString(),
        completedAt: null,
        commissionRate: 0.20,
        clientNotes: 'Categoria: Pintura'
      }
    ];
    
    const serviceIds = [];
    
    for (const service of services) {
      const docRef = await db.collection('services').add(service);
      serviceIds.push(docRef.id);
      console.log(`   ✅ Serviço criado: ${service.title} (ID: ${docRef.id})`);
    }
    
    // ===== CRIAR PAGAMENTOS DE TESTE =====
    console.log('\n📝 Criando pagamentos de teste...');
    
    const payments = [
      {
        serviceId: serviceIds[0],
        amount: 150.00,
        commissionAmount: 30.00,
        providerAmount: 120.00,
        status: 'completed',
        paymentMethod: 'pix',
        transactionId: 'pix123456789',
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        completedAt: admin.firestore.FieldValue.serverTimestamp()
      }
    ];
    
    for (const payment of payments) {
      await db.collection('payments').add(payment);
      console.log(`   ✅ Pagamento criado: R$ ${payment.amount}`);
    }
    
    // ===== CRIAR ALERTA DE PÂNICO DE TESTE =====
    console.log('\n📝 Criando alerta de pânico de teste...');
    
    const panicAlert = {
      userId: userUids[0], // Maria Silva
      latitude: -23.5505,
      longitude: -46.6333,
      status: 'resolved',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      resolvedAt: admin.firestore.FieldValue.serverTimestamp(),
      emergencyContact: '190'
    };
    
    await db.collection('panic_alerts').add(panicAlert);
    console.log('   ✅ Alerta de pânico criado');
    
    console.log('\n' + '='.repeat(50));
    console.log('✅ Seed concluído com sucesso!');
    console.log('='.repeat(50));
    console.log('\n📱 Credenciais de Login:');
    console.log('👤 Cliente: cliente@teste.com / (definir via Cloud Function)');
    console.log('👩 Prestadora: prestadora@teste.com / (definir via Cloud Function)');
    console.log('👩 Prestadora 2: prestadora2@teste.com / (definir via Cloud Function)');
    console.log('👨‍💼 Admin: admin@teste.com / (definir via Cloud Function)');
    console.log('\n⚠️  IMPORTANTE: As senhas precisam ser definidas via Cloud Functions!');
    console.log('   Use o script seed_test_users.js no diretório functions/');
    
    process.exit(0);
    
  } catch (error) {
    console.error('❌ Erro durante o seed:', error);
    process.exit(1);
  }
}

main();