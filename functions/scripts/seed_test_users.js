/**
 * Cria os usuários de teste (cliente, prestadora, admin) diretamente no
 * Firestore, já no formato do novo sistema de autenticação com bcrypt.
 *
 * Diferente do fluxo antigo (Firebase Authentication > Users > Add user),
 * agora os usuários não existem no Firebase Authentication até o primeiro
 * login pelo app (o Custom Token cria a conta automaticamente na primeira
 * vez). Este script só prepara os documentos no Firestore para que o login
 * funcione desde já.
 *
 * Como rodar:
 *   cd functions
 *   npm install
 *   node scripts/seed_test_users.js
 *
 * Requer que suas credenciais padrão do Google Cloud estejam configuradas
 * (rode `firebase login` e `gcloud auth application-default login`, ou
 * defina GOOGLE_APPLICATION_CREDENTIALS apontando pro JSON da service
 * account baixado em Project Settings > Service accounts).
 */

const admin = require('firebase-admin');
const bcrypt = require('bcryptjs');

admin.initializeApp();
const db = admin.firestore();

const BCRYPT_COST = 12;

const testUsers = [
  {
    name: 'Maria Silva',
    email: 'cliente@teste.com',
    password: 'cliente123',
    phone: '(11) 99999-1001',
    role: 'client',
  },
  {
    name: 'Ana Costa',
    email: 'prestadora@teste.com',
    password: 'prestadora123',
    phone: '(11) 99999-1002',
    role: 'provider',
  },
  {
    name: 'Administrador',
    email: 'admin@teste.com',
    password: 'admin123',
    phone: '(11) 99999-1003',
    role: 'admin',
  },
];

async function createTestUser({ name, email, password, phone, role }) {
  const normalizedEmail = email.trim().toLowerCase();
  const emailIndexRef = db.collection('email_index').doc(normalizedEmail);

  const existing = await emailIndexRef.get();
  if (existing.exists) {
    console.log(`⏭️  Já existe: ${email} (pulando)`);
    return;
  }

  const passwordHash = await bcrypt.hash(password, BCRYPT_COST);
  const uid = db.collection('users').doc().id;
  const now = admin.firestore.FieldValue.serverTimestamp();

  const batch = db.batch();

  batch.set(emailIndexRef, { uid });

  batch.set(db.collection('users_private').doc(uid), {
    email: normalizedEmail,
    passwordHash,
    role,
    failedAttempts: 0,
    lockUntil: null,
    createdAt: now,
  });

  batch.set(db.collection('users').doc(uid), {
    name,
    email: normalizedEmail,
    phone,
    role,
    createdAt: now,
  });

  await batch.commit();
  console.log(`✅ Criado: ${email} (uid: ${uid}, papel: ${role})`);
}

async function main() {
  console.log('Criando usuários de teste...');
  for (const user of testUsers) {
    await createTestUser(user);
  }
  console.log('Concluído.');
  process.exit(0);
}

main().catch((err) => {
  console.error('❌ Erro ao criar usuários de teste:', err);
  process.exit(1);
});
