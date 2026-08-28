# Maria Vai - Serviços para Mulheres

Um aplicativo completo de serviços para mulheres com botão de pânico, sistema de pagamentos e dashboard administrativo.

## 🎯 Funcionalidades Principais

### 🔴 Botão de Pânico
- **Acionamento de emergência**: Chama serviços de emergência automaticamente
- **Compartilhamento de localização**: Envia GPS para contatos de emergência
- **Interface dedicada**: Acesso rápido e intuitivo em situações de crise
- **Status em tempo real**: Acompanhamento do status do alerta

### 💰 Sistema de Pagamentos
- **Comissão de 20%**: Cálculo automático sobre cada serviço
- **Múltiplos métodos**: PIX, cartão de crédito/débito, boleto
- **Integração Mercado Pago**: Sistema de pagamento brasileiro popular
- **Dashboard financeiro**: Acompanhamento de pagamentos e comissões

### 👩 Cliente
- **Busca de serviços**: Categorias como limpeza, cuidados, alimentação, etc.
- **Solicitação de serviços**: Interface intuitiva para contratar prestadores
- **Acompanhamento de pedidos**: Status em tempo real dos serviços
- **Perfil personalizado**: Gerenciamento de contatos de emergência

### 👩‍💼 Prestador
- **Gestão de trabalhos**: Lista de serviços pendentes, em andamento e concluídos
- **Solicitação de pagamento**: Interface para cobrar após conclusão
- **Dashboard de ganhos**: Acompanhamento financeiro detalhado
- **Avaliação e reputação**: Sistema de feedback dos clientes

### 👨‍💼 Administrador
- **Visão geral**: Estatísticas de usuários, serviços e receitas
- **Gestão de pagamentos**: Histórico completo com detalhes de comissões
- **Gestão de usuários**: Clientes, prestadores e administradores
- **Monitoramento de alertas**: Acompanhamento de alertas de pânico em tempo real

## 🏗️ Arquitetura

O projeto segue a arquitetura **Clean Architecture** com separação clara de responsabilidades:

```
lib/
├── core/                    # Camada de infraestrutura
│   ├── db/                 # Banco de dados local
│   ├── network/            # Cliente HTTP
│   ├── storage/            # Armazenamento seguro
│   ├── payment/            # Sistema de pagamentos
│   └── router/             # Navegação
├── data/                   # Camada de dados
│   ├── datasources/        # Fontes de dados
│   ├── models/             # Modelos de dados
│   └── repositories/       # Implementações dos repositórios
├── domain/                 # Camada de domínio
│   ├── entities/           # Entidades de negócio
│   ├── repositories/       # Interfaces dos repositórios
│   └── usecases/           # Casos de uso
└── presentation/           # Camada de apresentação
    ├── features/           # Funcionalidades organizadas
    │   ├── auth/           # Autenticação
    │   ├── client/         # Interface do cliente
    │   ├── provider/       # Interface do prestador
    │   ├── admin/          # Dashboard administrativo
    │   └── panic/          # Botão de pânico
    ├── shared/             # Componentes compartilhados
    └── styles/             # Estilos e temas
```

## 🛠️ Tecnologias Utilizadas

### **Frontend**
- **Flutter 3.13.1** - Framework de desenvolvimento multiplataforma
- **Dart 3.13.1** - Linguagem de programação
- **Material Design 3** - Design system moderno
- **Google Fonts** - Tipografia (Poppins)

### **Navegação**
- **Go Router** - Roteamento declarativo

### **Funcionalidades Especiais**
- **Geolocator** - GPS e localização
- **Flutter Phone Direct Caller** - Chamadas de emergência
- **URL Launcher** - Integração com apps externos
- **Permission Handler** - Gerenciamento de permissões

### **Armazenamento e Rede**
- **Sembast** - Banco de dados local
- **Flutter Secure Storage** - Armazenamento seguro
- **Dio** - Cliente HTTP
- **Connectivity Plus** - Detecção de conectividade

### **UI Components**
- **Cached Network Image** - Cache de imagens
- **Flutter SVG** - Suporte a SVG
- **Shimmer** - Efeitos de loading

## 📦 Instalação e Configuração

### **Pré-requisitos**
- Flutter SDK 3.13.1 ou superior
- Dart SDK 3.13.1 ou superior
- Chrome (para desenvolvimento web)
- Git

### **Passos para Instalação**

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/mariavai_services.git
cd mariavai_services
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o app**
```bash
flutter run -d chrome
```

### **Configuração do Ambiente**

#### **Web**
```bash
flutter run -d chrome
```

#### **Android**
```bash
flutter run -d android
```

#### **iOS**
```bash
flutter run -d ios
```

## 🔧 Configuração da API

O app se conecta a uma API REST. Configure a URL base no arquivo:

```dart
// lib/core/network/api_client.dart
const String baseUrl = 'https://sua-api.com/api';
```

## 💳 Integração Mercado Pago

Para produção, configure as credenciais do Mercado Pago:

```dart
// lib/core/payment/mercadopago_config.dart
const String mercadoPagoAccessToken = 'seu_access_token';
const String mercadoPagoPublicKey = 'sua_public_key';
```

## 📱 Telas do Aplicativo

### **Login**
- Seleção de tipo de usuário (Cliente, Prestador, Administrador)
- Autenticação segura
- Validação de formulário

### **Cliente**
- Categorias de serviços em grid
- Lista de pedidos com status
- Perfil com contatos de emergência
- Botão de pânico sempre acessível

### **Prestador**
- Lista de trabalhos por status
- Dashboard de ganhos
- Solicitação de pagamento com cálculo de comissão
- Avaliação e perfil

### **Administrador**
- Estatísticas gerais
- Gestão de pagamentos
- Gestão de usuários
- Monitoramento de alertas de pânico

### **Botão de Pânico**
- Interface dedicada com botão grande
- Captura automática de localização
- Chamada para emergência (190)
- Envio de alerta para contatos
- Status do alerta em tempo real

## 🎯 Casos de Uso

### **Para Clientes**
1. **Buscar serviços**: Navegar por categorias e encontrar prestadores
2. **Solicitar serviços**: Criar pedidos com descrição e endereço
3. **Acompanhar status**: Verificar progresso dos serviços em tempo real
4. **Pagamento seguro**: Realizar pagamentos via Mercado Pago
5. **Emergência**: Acionar botão de pânico em situações de risco

### **Para Prestadores**
1. **Receber trabalhos**: Visualizar serviços disponíveis
2. **Executar serviços**: Aceitar e concluir trabalhos
3. **Cobrar serviços**: Solicitar pagamento após conclusão
4. **Acompanhar ganhos**: Verificar saldo e histórico financeiro
5. **Gerenciar perfil**: Atualizar disponibilidade e serviços

### **Para Administradores**
1. **Monitorar operações**: Visão geral de todas as atividades
2. **Gerenciar pagamentos**: Aprovar e processar pagamentos
3. **Gerenciar usuários**: Adicionar/remover clientes e prestadores
4. **Responder alertas**: Monitorar e responder a alertas de pânico
5. **Analisar dados**: Relatórios de desempenho e financeiros

## 📊 Estrutura de Dados

### **Entidades Principais**
- **User**: Clientes, prestadores e administradores
- **Service**: Ordens de serviço com status e cálculo de comissão
- **Payment**: Histórico de pagamentos com comissões
- **PanicAlert**: Alertas de emergência com localização

## 🔒 Segurança

- **Armazenamento seguro**: Dados sensíveis criptografados
- **Permissões**: Sistema de permissões granular
- **HTTPS**: Comunicação segura com APIs
- **Autenticação**: Sistema de login seguro

## 🧪 Testes

```bash
# Executar testes unitários
flutter test

# Executar testes de widget
flutter test test/widget_test.dart
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

## 🚀 Deploy

### **Web**
```bash
flutter build web --release
```

### **Android**
```bash
flutter build apk --release
```

### **iOS**
```bash
flutter build ios --release
```

---

**Desenvolvido com ❤️ para mulheres brasileiras**