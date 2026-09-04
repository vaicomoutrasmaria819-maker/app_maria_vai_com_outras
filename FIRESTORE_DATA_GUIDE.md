# 📊 Guia Completo - Criar Estrutura de Dados no Cloud Firestore

## ⚠️ Importante: Firestore ≠ SQL

**Firestore é NoSQL**, não usa "tabelas" e "colunas" como bancos de dados tradicionais.

| SQL (Banco Relacional) | Firestore (NoSQL) |
|------------------------|-------------------|
| Tabela | Coleção (Collection) |
| Linha | Documento (Document) |
| Coluna | Campo (Field) |
| Chave primária | ID do documento (automático ou manual) |
| JOIN | Subcoleções ou referências |

---

## 🏗️ Estrutura de Dados do Projeto

### 1. Coleção `users` (Usuários)
Armazena informações públicas dos usuários.

**Campos (Fields):**
```json
{
  "name": "Maria Silva",
  "email": "cliente@teste.com",
  "phone": "(11) 99999-1001",
  "role": "client",
  "photoUrl": null,
  "createdAt": "2026-08-28T00:00:00Z",
  "isActive": true
}
```

### 2. Coleção `users_private` (Dados Privados)
Armazena senhas e dados sensíveis (bloqueado para leitura pelo cliente).

**Campos (Fields):**
```json
{
  "hashedPassword": "$2b$12$abc123...",
  "loginAttempts": 0,
  "lockedUntil": null,
  "createdAt": "2026-08-28T00:00:00Z",
  "updatedAt": "2026-08-28T00:00:00Z"
}
```

### 3. Coleção `email_index` (Índice de Email)
Mapeia email → UID para busca rápida (usado pelas Cloud Functions).

**Campos (Fields):**
```json
{
  "email": "cliente@teste.com",
  "uid": "abc123def456",
  "createdAt": "2026-08-28T00:00:00Z"
}
```

### 4. Coleção `services` (Serviços)
Armazena solicitações de serviço.

**Campos (Fields):**
```json
{
  "clientId": "uid_cliente",
  "providerId": "uid_prestadora",
  "title": "Limpeza residencial",
  "description": "Limpeza completa de 3 quartos...",
  "price": 150.00,
  "status": "pending",
  "address": "Rua das Flores, 123",
  "createdAt": "2026-08-28T00:00:00Z",
  "scheduledDate": "2026-09-01T00:00:00Z",
  "completedAt": null,
  "commissionRate": 0.20,
  "clientNotes": "Categoria: Limpeza"
}
```

### 5. Coleção `payments` (Pagamentos)
Armazena informações de pagamentos.

**Campos (Fields):**
```json
{
  "serviceId": "service_id",
  "amount": 150.00,
  "commissionAmount": 30.00,
  "providerAmount": 120.00,
  "status": "completed",
  "paymentMethod": "pix",
  "transactionId": "pix123456",
  "createdAt": "2026-08-28T00:00:00Z",
  "completedAt": "2026-08-28T00:00:00Z"
}
```

### 6. Coleção `panic_alerts` (Alertas de Pânico)
Armazena alertas de emergência.

**Campos (Fields):**
```json
{
  "userId": "uid_usuario",
  "latitude": -23.5505,
  "longitude": -46.6333,
  "status": "active",
  "createdAt": "2026-08-28T00:00:00Z",
  "resolvedAt": null,
  "emergencyContact": "190"
}
```

---

## 📝 Como Criar Manualmente no Console

### Passo 1: Acessar o Banco de Dados
1. Firebase Console → Firestore Database
2. Selecione o banco `mariavaidb` (não o default)

### Passo 2: Criar Coleção
1. Clique no botão **"+ Iniciar coleção"** ou **"+ Start collection"**
2. Digite o nome da coleção (ex: `users`)
3. Clique em **Next** / **Próximo**

### Passo 3: Criar Primeiro Documento
1. **ID do documento**: Você pode deixar em **Auto-ID** (recomendado) ou digitar um ID personalizado
2. Clique em **Next** / **Próximo**

### Passo 4: Adicionar Campos
1. **Field** (Campo): Digite o nome do campo (ex: `name`)
2. **Type** (Tipo): Escolha o tipo:
   - **String** - Texto
   - **Number** - Número
   - **Boolean** - Verdadeiro/Falso
   - **Map** - Objeto JSON
   - **Array** - Lista
   - **Timestamp** - Data/hora
   - **Reference** - Referência a outro documento
   - **Geopoint** - Coordenadas GPS
3. **Value** (Valor): Digite o valor
4. Clique em **"+"** para adicionar mais campos
5. Clique em **Save** / **Salvar** quando terminar

### Passo 5: Adicionar Mais Documentos
1. Clique no nome da coleção para abri-la
2. Clique em **"+ Adicionar documento"** / **"+ Add document"**
3. Repita o processo

---

## 🎯 Exemplo Prático: Criar Usuário de Teste

### Coleção `users`

**Documento 1 (Cliente):**
- **ID**: Auto-ID
- **Campos**:
  - `name` (String): "Maria Silva"
  - `email` (String): "cliente@teste.com"
  - `phone` (String): "(11) 99999-1001"
  - `role` (String): "client"
  - `photoUrl` (String): null
  - `createdAt` (Timestamp): Data atual
  - `isActive` (Boolean): true

**Documento 2 (Prestadora):**
- **ID**: Auto-ID
- **Campos**:
  - `name` (String): "Ana Costa"
  - `email` (String): "prestadora@teste.com"
  - `phone` (String): "(11) 99999-1002"
  - `role` (String): "provider"
  - `photoUrl` (String): null
  - `createdAt` (Timestamp): Data atual
  - `isActive` (Boolean): true

**Documento 3 (Admin):**
- **ID**: Auto-ID
- **Campos**:
  - `name` (String): "Administrador"
  - `email` (String): "admin@teste.com"
  - `phone` (String): "(11) 99999-1003"
  - `role` (String): "admin"
  - `photoUrl` (String): null
  - `createdAt` (Timestamp): Data atual
  - `isActive` (Boolean): true

---

## 🤖 Criar Dados Automaticamente com Script

### Script de Seed (População Inicial)

⚠️ **IMPORTANTE**: Este script requer o arquivo `scripts/service-account.json` do Firebase.

**Se você não tem este arquivo, veja `SERVICE_ACCOUNT_GUIDE.md` para instruções ou use a opção manual abaixo.**

**Pré-requisitos:**
```bash
# Instalar Node.js se não tiver
# https://nodejs.org/

# As dependências já foram instaladas (firebase-admin)
```

**Para rodar:**
```bash
# Se estiver no diretório raiz do projeto:
node scripts/seed_firestore.js service-account.json

# Se estiver no diretório scripts:
node seed_firestore.js service-account.json
```

Onde `scripts/service-account.json` é o arquivo JSON da service account do Firebase (obtido em: Firebase Console → Project Settings → Service Accounts → Generate New Private Key).

**Se não tiver a service account ou quiser algo mais rápido:**
- Use a opção manual abaixo (criar dados no Console)
- Veja `SERVICE_ACCOUNT_GUIDE.md` para instruções detalhadas

---

## 🔍 Como Consultar Dados

### Buscar todos os usuários
```dart
final snapshot = await firestore.collection('users').get();
for (final doc in snapshot.docs) {
  print(doc.data());
}
```

### Buscar por email
```dart
final snapshot = await firestore
    .collection('users')
    .where('email', isEqualTo: 'cliente@teste.com')
    .get();
```

### Buscar por papel
```dart
final snapshot = await firestore
    .collection('users')
    .where('role', isEqualTo: 'provider')
    .get();
```

---

## 📊 Resumo da Estrutura

```
mariavaidb (banco de dados)
├── users (coleção)
│   ├── {auto-id} (documento cliente)
│   ├── {auto-id} (documento prestadora)
│   └── {auto-id} (documento admin)
├── users_private (coleção)
│   └── {uid} (documento com senha hasheada)
├── email_index (coleção)
│   └── {email} (documento mapeando email → uid)
├── services (coleção)
│   └── {auto-id} (documento de serviço)
├── payments (coleção)
│   └── {auto-id} (documento de pagamento)
└── panic_alerts (coleção)
    └── {auto-id} (documento de alerta)
```

---

## ⚡ Dicas Importantes

1. **IDs de Documento**: Use Auto-ID para maioria dos casos
2. **Tipos de Dados**: Escolha o tipo correto (String para texto, Number para números)
3. **Timestamps**: Use `FieldValue.serverTimestamp()` para data/hora atual
4. **Nulos**: Use `null` para campos opcionais
5. **Índices**: Firestore cria automaticamente índices simples
6. **Consultas**: Use `where()` para filtrar documentos

---

## 🚀 Próximos Passos

1. ✅ Criar coleção `users` no Console
2. ✅ Adicionar 3 documentos de teste (cliente, prestadora, admin)
3. ✅ Criar coleção `services`
4. ✅ Criar coleção `payments`
5. ✅ Criar coleção `panic_alerts`
6. ✅ Testar consultas no app

Tudo pronto para criar a estrutura de dados! 🎉