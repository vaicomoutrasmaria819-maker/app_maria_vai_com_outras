# Firebase Console Setup Guide

Este guia detalha tudo que você precisa configurar no Firebase Console para o projeto Maria Vai.

## 🔥 Projeto Firebase

**Projeto ID**: `mariavaicomoutras-e7c28`  
**Projeto Number**: `998255141329`

## 📋 Checklist de Configuração

### ✅ 1. Authentication (Autenticação)

#### Acessar
1. Firebase Console → Authentication → Sign-in method
2. Habilitar **Email/Password**

#### Criar Usuários de Teste Manualmente
Vá em Authentication → Users → Add user

**Usuário Cliente**:
- Email: `cliente@teste.com`
- Senha: `cliente123`
- UID: Será gerado automaticamente

**Usuário Prestadora**:
- Email: `prestadora@teste.com`
- Senha: `prestadora123`
- UID: Será gerado automaticamente

**Usuário Admin**:
- Email: `admin@teste.com`
- Senha: `admin123`
- UID: Será gerado automaticamente

### ✅ 2. Cloud Firestore Database

#### Criar Database
1. Firebase Console → Firestore Database → Create database
2. **Localização**: Escolha `southamerica-east1` (São Paulo) para melhor performance no Brasil
3. **Modo**: Começar em **Test mode** (pode alterar depois)
4. **Habilitar**: Cloud Firestore

#### Regras de Segurança (Security Rules)
Vá em Firestore Database → Rules e substitua por:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users podem ler/escrever seus próprios dados
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Services: clientes podem ler seus próprios, prestadores podem ler atribuídos
    match /services/{serviceId} {
      // Leitura: usuário autenticado pode ler se for cliente ou prestador do serviço
      allow read: if request.auth != null && 
        (resource.data.clientId == request.auth.uid || 
         resource.data.providerId == request.auth.uid ||
         resource.data.providerId == ''); // quotation phase
      
      // Criação: qualquer usuário autenticado pode criar
      allow create: if request.auth != null;
      
      // Atualização: cliente ou prestador do serviço pode atualizar
      allow update: if request.auth != null && 
        (resource.data.clientId == request.auth.uid || 
         resource.data.providerId == request.auth.uid);
    }
    
    // Payments: qualquer usuário autenticado pode ler, criar
    match /payments/{paymentId} {
      allow read, create: if request.auth != null;
    }
    
    // Panic alerts: usuários podem criar, todos podem ler
    match /panic_alerts/{alertId} {
      allow create: if request.auth != null;
      allow read: if request.auth != null;
      allow update: if request.auth != null;
    }
  }
}
```

#### Criar Coleções Manualmente (Após Setup)

**Coleção `users`**:
Crie documentos para cada usuário de teste:

```json
// Cliente
{
  "name": "Maria Silva",
  "email": "cliente@teste.com",
  "phone": "(11) 99999-1001",
  "role": "client",
  "photoUrl": null,
  "isActive": true,
  "createdAt": "2026-08-28T00:00:00Z"
}

// Prestadora
{
  "name": "Ana Costa",
  "email": "prestadora@teste.com",
  "phone": "(11) 99999-1002",
  "role": "provider",
  "gender": "female",
  "photoUrl": null,
  "isActive": true,
  "createdAt": "2026-08-28T00:00:00Z"
}

// Admin
{
  "name": "Administrador",
  "email": "admin@teste.com",
  "phone": "(11) 99999-1003",
  "role": "admin",
  "gender": null,
  "photoUrl": null,
  "isActive": true,
  "createdAt": "2026-08-28T00:00:00Z"
}
```

### ✅ 3. Firebase Storage

#### Criar Storage
1. Firebase Console → Storage → Get started
2. **Localização**: `southamerica-east1` (mesma do Firestore)
3. **Regras**: Começar em Test mode
4. **Habilitar**: Firebase Storage

#### Regras de Storage
Vá em Storage → Rules e substitua por:

```firestore
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

#### Criar Pastas (Opcional, para organização)
- `/profile-pictures/` - Fotos de perfil
- `/service-photos/` - Fotos dos serviços
- `/documents/` - Documentos

### ✅ 4. Cloud Messaging (FCM)

#### Configurar
1. Firebase Console → Cloud Messaging → Get started
2. **Habilitar**: Cloud Messaging API
3. **Configurar** Web Push notification certificate (para web)

#### Android Config
1. Cloud Messaging → Configurações do projeto → Android
2. Copie o `Server Key` (se necessário para backend)

#### iOS Config
1. Cloud Messaging → Configurações do projeto → iOS
2. Upload do certificado APNs (para push notifications)

### ✅ 5. Hosting (Deploy Web)

#### Configurar Hosting
1. Firebase Console → Hosting → Get started
2. **Project**: mariavaicomoutras-e7c28
3. **Public directory**: build/web
4. **Framework**: Flutter Web

#### Deploy Manual (Teste)
```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Inicializar (se ainda não fez)
firebase init

# Deploy
firebase deploy --only hosting
```

### ✅ 6. Indexes (Índices Compostos)

O Firestore criará índices automaticamente quando necessário, mas você pode criar manualmente:

Vá em Firestore Database → Indexes → Composite Index → Add index

**Índice para Services por Cliente**:
- **Collection ID**: services
- **Fields**: 
  - clientId (Ascending)
  - createdAt (Descending)
- **Query Scope**: Collection

**Índice para Services por Prestadora**:
- **Collection ID**: services
- **Fields**:
  - providerId (Ascending)
  - createdAt (Descending)
- **Query Scope**: Collection

### ✅ 7. Service Account (Para CI/CD)

#### Criar Service Account
1. Firebase Console → Project Settings → Service accounts
2. Clique em **Generate New Private Key**
3. Salve o arquivo JSON

#### Configurar no GitHub
1. Vá ao repositório GitHub → Settings → Secrets and variables → Actions
2. Adicione secret: `FIREBASE_SERVICE_ACCOUNT`
3. Cole o conteúdo do arquivo JSON

## 🧪 Scripts para Criar Usuários de Teste

Use o script Python abaixo para criar usuários de teste automaticamente:

```python
# firebase_test_users.py
import firebase_admin
from firebase_admin import credentials, auth, firestore
import json

# Inicializar Firebase Admin SDK
cred = credentials.Certificate("service-account.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

def create_test_user(email, password, name, phone, role, gender=None):
    try:
        # Criar usuário no Authentication
        user = auth.create_user(
            email=email,
            password=password,
            display_name=name
        )
        
        # Criar documento no Firestore
        user_data = {
            'name': name,
            'email': email,
            'phone': phone,
            'role': role,
            'photoUrl': None,
            'isActive': True,
            'createdAt': firestore.SERVER_TIMESTAMP
        }
        
        if gender:
            user_data['gender'] = gender
        
        db.collection('users').document(user.uid).set(user_data)
        
        print(f"✅ Usuário criado: {email} (UID: {user.uid})")
        return user.uid
        
    except Exception as e:
        print(f"❌ Erro ao criar usuário {email}: {e}")
        return None

# Criar usuários de teste
print("Criando usuários de teste...")

# Cliente
create_test_user(
    email="cliente@teste.com",
    password="cliente123",
    name="Maria Silva",
    phone="(11) 99999-1001",
    role="client"
)

# Prestadora feminina
create_test_user(
    email="prestadora@teste.com",
    password="prestadora123",
    name="Ana Costa",
    phone="(11) 99999-1002",
    role="provider",
    gender="female"
)

# Admin
create_test_user(
    email="admin@teste.com",
    password="admin123",
    name="Administrador",
    phone="(11) 99999-1003",
    role="admin"
)

print("✅ Usuários de teste criados com sucesso!")
```

Para rodar:
```bash
pip install firebase-admin
python firebase_test_users.py
```

## 🎯 Credenciais de Teste

### Login Cliente
- **Email**: cliente@teste.com
- **Senha**: cliente123

### Login Prestadora
- **Email**: prestadora@teste.com
- **Senha**: prestadora123

### Login Admin
- **Email**: admin@teste.com
- **Senha**: admin123
- **Código de Acesso**: MARIAVAI-ADMIN-2026

## 📱 Teste do Fluxo Completo

### 1. Como Cliente
1. Faça login com `cliente@teste.com`
2. Clique em "Solicitar Orçamento"
3. Preencha o formulário
4. Envie a solicitação

### 2. Como Prestadora
1. Faça login com `prestadora@teste.com`
2. Vá para aba "Orçamentos"
3. Veja a solicitação em "Disponíveis"
4. Clique em "Aceitar Serviço"
5. Veja aparecer em "Aceitos"

### 3. Como Admin
1. Faça login com `admin@teste.com`
2. Vá para "Pagamentos"
3. Monitore os pagamentos em tempo real
4. Vá para "Alertas" para ver alertas de pânico

## 🔒 Considerações de Segurança

### Para Produção
1. **Mudar regras de segurança** para modo production
2. **Remover usuários de teste** ou desativá-los
3. **Trocar código de acesso admin** por algo mais seguro
4. **Usar Cloud Functions** para validação server-side
5. **Configurar monitoramento** e alertas

### SQL vs NoSQL
- **Firestore é NoSQL** (document-based)
- **Não usa SQL tradicional**
- **Queries são feitas via SDK do Flutter**
- **Indexes são criados no Console**, não SQL

## 🚀 Próximos Passos

1. ✅ Configurar Authentication com usuários de teste
2. ✅ Criar Firestore Database com regras de segurança
3. ✅ Configurar Storage para imagens
4. ✅ Configurar Cloud Messaging para notificações
5. ✅ Criar Service Account para CI/CD
6. ✅ Testar fluxo completo com usuários de teste
7. ✅ Ajustar regras de segurança para produção

## 💡 Dicas Importantes

- **Localização**: Use `southamerica-east1` para melhor performance no Brasil
- **Test Mode**: Útil para desenvolvimento, mas mude para produção
- **Service Account**: Mantenha seguro, nunca commit no GitHub
- **Monitoramento**: Configure alertas para erros e uso excessivo
- **Backups**: Firestore tem backup automático, mas verifique configurações