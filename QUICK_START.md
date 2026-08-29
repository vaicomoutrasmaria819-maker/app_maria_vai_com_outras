# 🚀 Quick Start - Configuração Rápida do Firebase

## Passo 1: Configurar Firebase Console

### 1. Authentication
- Acesse: Firebase Console → Authentication → Sign-in method
- Habilite: **Email/Password**
- Crie usuários manualmente ou use os scripts abaixo

### 2. Firestore Database
- Acesse: Firestore Database → Create database
- Localização: `southamerica-east1` (São Paulo)
- Regras: Copie as regras do arquivo `FIREBASE_CONSOLE_SETUP.md`

### 3. Storage
- Acesse: Storage → Get started
- Localização: `southamerica-east1`
- Regras: Copie as regras do arquivo `FIREBASE_CONSOLE_SETUP.md`

### 4. Cloud Messaging
- Acesse: Cloud Messaging → Get started
- Habilite: Cloud Messaging API

### 5. Service Account (Para CI/CD)
- Acesse: Project Settings → Service accounts
- Clique: Generate New Private Key
- Salve: JSON file seguro
- Configure: No GitHub como secret `FIREBASE_SERVICE_ACCOUNT`

## Passo 2: Criar Usuários de Teste

### Opção A: Manual (No Console)
Vá em Authentication → Users → Add user

**Cliente**:
- Email: `cliente@teste.com`
- Senha: `cliente123`

**Prestadora**:
- Email: `prestadora@teste.com`
- Senha: `prestadora123`

**Admin**:
- Email: `admin@teste.com`
- Senha: `admin123`

### Opção B: Script Automático

#### Python:
```bash
pip install firebase-admin
python scripts/create_test_users.py service-account.json
```

#### Dart:
```bash
dart scripts/create_test_users.dart service-account.json
```

## Passo 3: Criar Documentos no Firestore

### Coleção `users`
Crie documentos com os UIDs dos usuários criados:

```json
{
  "name": "Maria Silva",
  "email": "cliente@teste.com",
  "phone": "(11) 99999-1001",
  "role": "client",
  "isActive": true,
  "createdAt": "2026-08-28T00:00:00Z"
}
```

```json
{
  "name": "Ana Costa",
  "email": "prestadora@teste.com",
  "phone": "(11) 99999-1002",
  "role": "provider",
  "gender": "female",
  "isActive": true,
  "createdAt": "2026-08-28T00:00:00Z"
}
```

```json
{
  "name": "Administrador",
  "email": "admin@teste.com",
  "phone": "(11) 99999-1003",
  "role": "admin",
  "isActive": true,
  "createdAt": "2026-08-28T00:00:00Z"
}
```

## Passo 4: Testar o App

### Login Cliente
- Email: `cliente@teste.com`
- Senha: `cliente123`

### Login Prestadora
- Email: `prestadora@teste.com`
- Senha: `prestadora123`

### Login Admin
- Email: `admin@teste.com`
- Senha: `admin123`
- Código: `MARIAVAI-ADMIN-2026`

## 🔑 Importante

- **Firestore é NoSQL**, não usa SQL tradicional
- **Queries são feitas via SDK Flutter**, não SQL
- **Índices são criados no Console**, não comandos SQL
- **Regras de segurança** definem quem pode ler/escrever
- **Service Account** é necessária para scripts admin e CI/CD

## 📚 Documentação Completa

Para detalhes completos, veja: `FIREBASE_CONSOLE_SETUP.md`