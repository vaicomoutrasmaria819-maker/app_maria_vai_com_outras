import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Inicializar notificações
  Future<void> initialize() async {
    // Solicitar permissão para notificações
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permissão de notificação concedida');
    } else {
      print('Permissão de notificação negada');
    }

    // Obter token FCM
    String? token = await _messaging.getToken();
    print('FCM Token: $token');

    // Escutar mensagens em foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mensagem recebida em foreground: ${message.notification?.title}');
      _handleForegroundMessage(message);
    });

    // Escutar mensagens quando o app está em background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Mensagem aberta do background: ${message.notification?.title}');
      _handleBackgroundMessage(message);
    });
  }

  // Obter token FCM
  Future<String?> getFCMToken() async {
    return await _messaging.getToken();
  }

  // Atualizar token (quando o token muda)
  void onTokenRefresh(Function(String) onNewToken) {
    _messaging.onTokenRefresh.listen((token) {
      onNewToken(token);
    });
  }

  // Inscrever em tópico
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    print('Inscrito no tópico: $topic');
  }

  // Desinscrever de tópico
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    print('Desinscrito do tópico: $topic');
  }

  // Tratar mensagem em foreground
  void _handleForegroundMessage(RemoteMessage message) {
    // Aqui você pode mostrar uma notificação local ou snackbar
    // Por enquanto, apenas log
    print('Título: ${message.notification?.title}');
    print('Corpo: ${message.notification?.body}');
    print('Dados: ${message.data}');
  }

  // Tratar mensagem de background
  void _handleBackgroundMessage(RemoteMessage message) {
    // Navegar para a tela apropriada
    print('Dados da mensagem de background: ${message.data}');
  }

  // Tópicos específicos para o app
  static const String panicAlertsTopic = 'panic_alerts';
  static const String adminTopic = 'admins';
  static const String providersTopic = 'providers';
  static const String clientsTopic = 'clients';
}