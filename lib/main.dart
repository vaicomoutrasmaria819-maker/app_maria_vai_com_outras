import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/router/app_router.dart';
import 'core/firebase/firebase_service.dart';
import 'core/firebase/messaging_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase. Se falhar (ex: chaves inválidas/config ausente),
  // não deixamos o app travado na splash screen — logamos e seguimos.
  try {
    await FirebaseService.initialize();
  } catch (e) {
    debugPrint('Falha ao inicializar Firebase: $e');
  }

  // Inicializar notificações com timeout: no Flutter Web, getToken() do
  // Firebase Messaging fica pendurado para sempre se não houver um
  // firebase-messaging-sw.js registrado corretamente.
  try {
    await MessagingService().initialize().timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        debugPrint('Inicialização de mensagens expirou (timeout) - continuando sem FCM.');
      },
    );
  } catch (e) {
    debugPrint('Falha ao inicializar mensagens: $e');
  }

  runApp(const MariaVaiApp());
}

class MariaVaiApp extends StatelessWidget {
  const MariaVaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Maria Vai - Serviços para Mulheres',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63), // Pink for women-focused app
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routerConfig: appRouter,
    );
  }
}