# 📸 Como Adicionar o Logo ao App

## 📍 Onde Colocar a Imagem do Logo

### Passo 1: Salvar a Imagem
1. Salve a imagem do logo que você mostrou
2. Nomeie o arquivo como: `logo.png`
3. Coloque no diretório: `assets/images/logo.png`

### Passo 2: Verificar Estrutura
A estrutura deve ficar assim:
```
mariavai_services/
├── assets/
│   └── images/
│       └── logo.png  ← Coloque sua imagem aqui
├── lib/
└── pubspec.yaml
```

### Passo 3: Recarregar o App
Após adicionar a imagem:
1. Rode: `flutter pub get`
2. Rode: `flutter run -d chrome` (ou seu dispositivo)
3. O logo aparecerá na tela de login

---

## 🎨 Se Não Tiver a Imagem

O app tem um fallback automático:
- Se a imagem `logo.png` não existir, mostra um ícone de construção
- Isso evita que o app quebre

---

## 📐 Tamanhos Sugeridos

Para melhor qualidade:
- **PNG** com fundo transparente
- **Resolução**: 1024x614 pixels (proporção do logo)
- **Formato**: logo.png

---

## 🔧 Problemas Comuns

### Imagem não aparece
- Verifique se o arquivo está em `assets/images/logo.png`
- Verifique se o nome está exatamente `logo.png` (maiúsculas/minúsculas)
- Rode `flutter pub get` novamente

### Erro de asset
- Verifique se `assets/images/` está no `pubspec.yaml`
- A indentação do YAML deve estar correta

---

## ✅ Pronto

Depois de adicionar a imagem, o app mostrará o logo real na tela de login!