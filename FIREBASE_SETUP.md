# Firebase Setup — Maria Vai

**Projeto**: `mariavaicomoutras-e7c28` (número `998255141329`)

⚠️ Este projeto usa um sistema de **autenticação próprio com bcrypt**, não o
provedor de Email/Senha do Firebase Authentication. Se você chegou aqui
vindo de uma versão antiga deste guia (Firebase Auth direto), a seção
"Authentication" abaixo mudou bastante — leia com atenção antes de seguir
os passos antigos de memória.

## 1. Banco de dados não-default

Este projeto usa um Firestore com ID **`mariavaidb`** (não `(default)`).
Isso já está configurado em três lugares — se algum dia mudar o ID do
banco, é aqui que precisa ajustar:

- `firebase.json` → `firestore[0].database`
- `functions/index.js` e `functions/scripts/seed_test_users.js` →
  `getFirestore(admin.app(), 'mariavaidb')`
- `lib/core/firebase/firestore_service.dart` e
  `lib/core/firebase/auth_service.dart` →
  `FirebaseFirestore.instanceFor(databaseId: 'mariavaidb')`

## 2. Como a autenticação funciona aqui

- O app **não** chama `FirebaseAuth.createUserWithEmailAndPassword` nem
  `signInWithEmailAndPassword`.
- Duas Cloud Functions (`functions/index.js`) fazem o trabalho:
  - `registerUser`: recebe nome/email/telefone/senha/papel, hasheia a
    senha com **bcrypt** (custo 12) e salva em `users_private/{uid}`
    (coleção bloqueada para qualquer leitura via cliente).
  - `loginUser`: busca o hash, compara com bcrypt, e bloqueia a conta por
    15 minutos após 5 tentativas erradas.
- Em caso de sucesso, ambas devolvem um **Firebase Custom Token**. O app
  troca esse token por uma sessão real com `signInWithCustomToken()` — é
  só nesse momento que a conta passa a existir no Firebase Authentication
  (criada automaticamente pelo SDK, sem senha nenhuma associada lá).
- Isso significa: **você não cria usuários manualmente em
  Authentication → Users → Add user**. Eles só aparecem lá depois do
  primeiro login bem-sucedido pelo app.

## 3. O que configurar no Console

### Authentication
Nada a habilitar aqui — não usamos nenhum provedor de sign-in do
Firebase Auth (nem Email/Senha, nem Google). Os Custom Tokens funcionam
sem isso.

### Cloud Firestore
1. Firestore Database → Create database
2. Localização: `southamerica-east1` (São Paulo)
3. Modo: **produção** (não teste — as regras em `firestore.rules` já
   cobrem os casos de uso reais do app)
4. Publique as regras e índices deste projeto:
   ```bash
   firebase deploy --only firestore:rules,firestore:indexes
   ```

### Firebase Storage
1. Storage → Get started
2. Localização: mesma do Firestore (`southamerica-east1`)
3. Modo produção
4. Publique as regras:
   ```bash
   firebase deploy --only storage
   ```

### Cloud Functions
1. Requer o plano **Blaze** (pay-as-you-go) — o Spark (grátis) não
   permite Cloud Functions. Tem cota gratuita mensal generosa.
2. Defina o código de acesso de admin como secret (nunca no código):
   ```bash
   firebase functions:secrets:set ADMIN_ACCESS_CODE
   ```
3. Deploy:
   ```bash
   cd functions && npm install && cd ..
   firebase deploy --only functions
   ```

### Cloud Messaging (notificações push)
1. Cloud Messaging → Get started
2. Web: já configurado via `web/firebase-messaging-sw.js`
3. iOS: precisa subir o certificado APNs quando for publicar de verdade

## 4. Usuários de teste

Como não existe mais tela de "Add user" manual no Console para este
fluxo, use o script já pronto:

```bash
cd functions
npm install
node scripts/seed_test_users.js
```

Isso cria diretamente no Firestore (com senha já em bcrypt):

| Papel      | Email                  | Senha           |
|------------|------------------------|-----------------|
| Cliente    | cliente@teste.com      | cliente123      |
| Prestadora | prestadora@teste.com   | prestadora123   |
| Admin      | admin@teste.com        | admin123        |

O código de acesso de admin pra criar novas contas de admin pelo app é o
valor que você definiu no `ADMIN_ACCESS_CODE` (passo acima) — não existe
mais um código fixo no código-fonte do app.

## 5. Estrutura de dados (coleções)

- `users/{uid}` — perfil público (nome, email, telefone, papel)
- `users_private/{uid}` — **nunca lido pelo cliente**: hash bcrypt, papel,
  contador de tentativas de login
- `email_index/{email}` — mapeia email → uid, usado só pelas functions
- `services/{id}` — solicitações de serviço (`clientId`, `providerId`,
  `status`, `createdAt`, ...)
- `payments/{id}` — pagamentos (`serviceId`, `amount`, `status`, ...) —
  não guarda `clientId`/`providerId` direto, as regras buscam o serviço
  relacionado pra checar permissão
- `panic_alerts/{id}` — alertas de pânico (`userId`, `latitude`,
  `longitude`, `status`, ...) — leitura restrita ao próprio usuário e a
  admins, por ser dado sensível de segurança pessoal

## 6. Storage — pastas

- `/profile-pictures/{uid}/` — cada usuário só escreve na própria pasta;
  qualquer usuário autenticado pode ler (perfis são exibidos entre
  cliente/prestadora)
- `/service-photos/{serviceId}/` — leitura/escrita liberada a qualquer
  autenticado (ajustar depois se quiser restringir ao par
  cliente/prestador daquele serviço)
- `/documents/{uid}/` — documentos sensíveis (ex: identidade de
  prestadoras), só o dono acessa

## 7. Deploy completo (checklist)

```bash
firebase login
cd C:\Users\Paulo\mariavai_services
firebase deploy --only firestore:rules,firestore:indexes,storage,functions
```

## 8. Troubleshooting

**"Firebase has not been correctly initialized"**
Confira `lib/firebase_options.dart` — as chaves precisam ser reais (não
`AIzaSyDummyKeyForDevelopment`), uma por plataforma.

**"api-key-not-valid"**
Geralmente é cache do navegador (Service Worker do Flutter Web). Feche o
Chrome, rode `flutter clean && flutter pub get` e teste de novo com
Ctrl+Shift+R.

**"PERMISSION_DENIED" no Firestore/Storage**
Confira se `firestore.rules`/`storage.rules` foram de fato publicadas
(`firebase deploy --only firestore:rules,storage`), e se o campo que a
regra verifica (ex: `clientId`) realmente existe no documento.

**Erro ao chamar `registerUser`/`loginUser` do app**
Confirme que o plano é Blaze e que o deploy das functions terminou sem
erro (`firebase deploy --only functions`). Veja os logs com
`firebase functions:log`.

## 9. Para produção (antes de lançar de verdade)

1. Trocar `ADMIN_ACCESS_CODE` por um valor forte e único
2. Revisar `firestore.rules`/`storage.rules` — comece restritivo e libere
   só o que o app realmente usa
3. Ativar o **Firebase App Check** (Play Integrity no Android, reCAPTCHA
   v3 na Web) pra impedir chamadas às Cloud Functions vindas de fora do
   app
4. Configurar alerta de orçamento em Settings → Usage and billing
5. Implementar o fluxo de "esqueci minha senha" (ainda não existe no
   sistema de auth próprio — precisa de uma Cloud Function de envio de
   código por email)
