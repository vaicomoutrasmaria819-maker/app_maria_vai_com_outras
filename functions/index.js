/**
 * Autenticação própria com bcrypt para o MariaVai.
 *
 * Arquitetura (por quê isso é seguro):
 * - A senha em texto puro chega aqui via HTTPS Callable (criptografado em
 *   trânsito pelo próprio HTTPS), nunca é salva.
 * - O hash bcrypt fica em `users_private/{uid}`, uma coleção que as regras
 *   do Firestore bloqueiam 100% para leitura via cliente — só o Admin SDK
 *   (rodando aqui no servidor) consegue ler.
 * - Depois de validar a senha, geramos um Firebase Custom Token
 *   (admin.auth().createCustomToken). O app Flutter troca esse token por
 *   uma sessão real via signInWithCustomToken(), e a partir daí
 *   `request.auth.uid` funciona normalmente nas regras do Firestore —
 *   sem isso, não teríamos como aplicar permissões por papel
 *   (cliente/prestadora/admin) com segurança.
 * - `email_index/{emailNormalizado}` existe só para localizar o uid a
 *   partir do email sem precisar de uma query irrestrita na coleção de
 *   usuários.
 */

const { onCall, HttpsError } = require('firebase-functions/v2/https');
const { setGlobalOptions } = require('firebase-functions/v2');
const admin = require('firebase-admin');
const { getFirestore } = require('firebase-admin/firestore');
const bcrypt = require('bcryptjs');

admin.initializeApp();
setGlobalOptions({ region: 'southamerica-east1', maxInstances: 10 });

// O banco Firestore deste projeto foi criado com o ID 'mariavaidb' (não
// '(default)'), então precisamos apontar explicitamente pra ele — do
// contrário o Admin SDK tentaria acessar um banco '(default)' que não
// existe neste projeto.
const db = getFirestore(admin.app(), 'mariavaidb');

const BCRYPT_COST = 12;
const MAX_FAILED_ATTEMPTS = 5;
const LOCK_DURATION_MS = 15 * 60 * 1000; // 15 minutos
const VALID_ROLES = ['client', 'provider', 'admin'];

// Código de convite de admin: fica só na configuração do servidor, nunca
// no app compilado. Defina com:
//   firebase functions:config:set admin.access_code="ALGO-BEM-DIFICIL"
// (ou, com a v2, use um Secret Manager binding em vez de functions:config).
function getAdminAccessCode() {
  return process.env.ADMIN_ACCESS_CODE || null;
}

function normalizeEmail(email) {
  return String(email || '').trim().toLowerCase();
}

function assertValidPassword(password) {
  if (typeof password !== 'string' || password.length < 8) {
    throw new HttpsError(
      'invalid-argument',
      'A senha deve ter pelo menos 8 caracteres.'
    );
  }
}

exports.registerUser = onCall(async (request) => {
  const { name, email, phone, password, role, adminAccessCode } =
    request.data || {};

  if (!name || !email || !phone || !password || !role) {
    throw new HttpsError('invalid-argument', 'Preencha todos os campos.');
  }
  if (!VALID_ROLES.includes(role)) {
    throw new HttpsError('invalid-argument', 'Papel de usuário inválido.');
  }
  assertValidPassword(password);

  if (role === 'admin') {
    const expected = getAdminAccessCode();
    if (!expected || adminAccessCode !== expected) {
      throw new HttpsError(
        'permission-denied',
        'Código de acesso administrativo inválido.'
      );
    }
  }

  const normalizedEmail = normalizeEmail(email);
  const emailIndexRef = db.collection('email_index').doc(normalizedEmail);

  const existing = await emailIndexRef.get();
  if (existing.exists) {
    throw new HttpsError('already-exists', 'Este email já está cadastrado.');
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

  // Perfil público/consultável pelo próprio app (sem o hash, claro).
  batch.set(db.collection('users').doc(uid), {
    name,
    email: normalizedEmail,
    phone,
    role,
    createdAt: now,
  });

  await batch.commit();

  const token = await admin.auth().createCustomToken(uid, { role });
  return { token, uid, role };
});

exports.loginUser = onCall(async (request) => {
  const { email, password } = request.data || {};

  if (!email || !password) {
    throw new HttpsError('invalid-argument', 'Preencha email e senha.');
  }

  const normalizedEmail = normalizeEmail(email);
  const indexSnap = await db
    .collection('email_index')
    .doc(normalizedEmail)
    .get();

  // Mensagem genérica de propósito: não revelamos se o email existe ou não.
  const invalidCredentialsError = () =>
    new HttpsError('unauthenticated', 'Email ou senha inválidos.');

  if (!indexSnap.exists) {
    throw invalidCredentialsError();
  }

  const { uid } = indexSnap.data();
  const privateRef = db.collection('users_private').doc(uid);
  const privateSnap = await privateRef.get();

  if (!privateSnap.exists) {
    throw invalidCredentialsError();
  }

  const userPrivate = privateSnap.data();
  const now = Date.now();

  if (userPrivate.lockUntil && userPrivate.lockUntil > now) {
    const minutesLeft = Math.ceil((userPrivate.lockUntil - now) / 60000);
    throw new HttpsError(
      'resource-exhausted',
      `Muitas tentativas erradas. Tente novamente em ${minutesLeft} minuto(s).`
    );
  }

  const passwordMatches = await bcrypt.compare(
    password,
    userPrivate.passwordHash
  );

  if (!passwordMatches) {
    const failedAttempts = (userPrivate.failedAttempts || 0) + 1;
    const update = { failedAttempts };
    if (failedAttempts >= MAX_FAILED_ATTEMPTS) {
      update.lockUntil = now + LOCK_DURATION_MS;
      update.failedAttempts = 0;
    }
    await privateRef.update(update);
    throw invalidCredentialsError();
  }

  // Login certo: zera o contador de tentativas.
  if (userPrivate.failedAttempts || userPrivate.lockUntil) {
    await privateRef.update({ failedAttempts: 0, lockUntil: null });
  }

  const token = await admin.auth().createCustomToken(uid, {
    role: userPrivate.role,
  });

  return { token, uid, role: userPrivate.role };
});
