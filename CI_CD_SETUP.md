# CI/CD Setup Guide

Este guia explica como configurar o pipeline de CI/CD para o projeto Maria Vai.

## 🔄 CI/CD Pipeline Configurado

### **CI (Continuous Integration)**
- **Trigger**: Push em branches `main` e `develop`, Pull Requests
- **Jobs**:
  - `build-and-test`: Formatação, análise, testes
  - `build-web`: Build para web
  - `build-android`: Build APK para Android

### **CD (Continuous Deployment)**
- **Trigger**: Push em `main`, tags de versão (`v*`)
- **Jobs**:
  - `deploy-web`: Deploy automático para Firebase Hosting
  - `deploy-android`: Deploy para Google Play Store

## 🔐 Secrets Necessários no GitHub

Configure os seguintes secrets em: `Settings → Secrets and variables → Actions`

### **Firebase Secrets**
- `FIREBASE_SERVICE_ACCOUNT`: JSON da service account do Firebase
  - Como obter: Firebase Console → Project Settings → Service Accounts → Generate New Private Key

### **Android Secrets**
- `ANDROID_SIGNING_KEY`: Chave de assinatura Android (base64)
- `ANDROID_ALIAS`: Alias da keystore
- `ANDROID_KEY_STORE_PASSWORD`: Senha da keystore
- `ANDROID_KEY_PASSWORD`: Senha da chave

### **Google Play Secrets**
- `GOOGLE_PLAY_SERVICE_ACCOUNT`: JSON da service account do Google Play Console

## 📦 Versionamento Semântico

O projeto usa versionamento semântico: `MAJOR.MINOR.PATCH+BUILD_NUMBER`

### **Regras de Versionamento**
- **MAJOR**: Mudanças incompatíveis na API
- **MINOR**: Funcionalidades novas compatíveis
- **PATCH**: Correções de bugs compatíveis
- **BUILD_NUMBER**: Incrementa em cada build

### **Scripts de Release**

#### **Linux/Mac**
```bash
./scripts/release.sh [major|minor|patch]
```

#### **Windows**
```powershell
.\scripts\release.ps1 [major|minor|patch]
```

### **Exemplos**
```bash
# Release major (nova versão principal)
./scripts/release.sh major

# Release minor (nova funcionalidade)
./scripts/release.sh minor

# Release patch (correção de bug)
./scripts/release.sh patch
```

## 🚀 Fluxo de Trabalho

### **Desenvolvimento**
1. Crie branch: `git checkout -b feature/nova-funcionalidade`
2. Faça commits: `git commit -m "feat: adicionar nova funcionalidade"`
3. Push: `git push origin feature/nova-funcionalidade`
4. Abra Pull Request para `develop`

### **Release**
1. Atualize CHANGELOG.md
2. Execute script de release: `./scripts/release.sh minor`
3. Push com tags: `git push --follow-tags`
4. CI/CD executa automaticamente:
   - Build e testes
   - Deploy para Firebase Hosting (se main)
   - Deploy para Google Play (se tag de versão)

## 🧪 Testes Locais

### **Executar testes**
```bash
flutter test
flutter test --coverage
```

### **Análise de código**
```bash
flutter analyze
dart format .
```

### **Build local**
```bash
# Web
flutter build web --release

# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📊 Monitoramento

### **GitHub Actions**
- Acompanhe em: `Actions` tab do repositório
- Logs detalhados de cada job
- Status dos builds e deploys

### **Firebase Hosting**
- Deploy automático para `mariavaicomoutras-e7c28.web.app`
- Histórico de releases
- Rollback automático em caso de falha

### **Google Play Console**
- Upload automático para track `internal`
- Status: `completed` (aprovado para teste)
- Gerencie releases manualmente para produção

## 🔧 Troubleshooting

### **Build falha no CI**
- Verifique logs no GitHub Actions
- Execute comandos localmente para reproduzir
- Verifique dependências no pubspec.yaml

### **Deploy Firebase falha**
- Verifique `FIREBASE_SERVICE_ACCOUNT` secret
- Confirme permissões da service account
- Verifique projeto Firebase correto

### **Deploy Android falha**
- Verifique secrets de assinatura Android
- Confirme formato base64 da chave
- Verifique permissões Google Play Console

## 📝 Conventional Commits

Use mensagens de commit padronizadas:

- `feat:` nova funcionalidade
- `fix:` correção de bug
- `docs:` documentação
- `style:` formatação/código
- `refactor:` refatoração
- `test:` testes
- `chore:` manutenção

### **Exemplos**
```
feat: adicionar botão de pânico com GPS
fix: corrigir navegação no login
docs: atualizar guia de Firebase
chore(release): bump version to 1.1.0+2
```

## 🎯 Próximos Passos

1. ✅ Configurar secrets no GitHub
2. ✅ Testar pipeline com um commit
3. ✅ Configurar Firebase Hosting
4. ✅ Configurar Google Play Console
5. ✅ Testar primeiro release automatizado
6. ✅ Configurar branch protection rules