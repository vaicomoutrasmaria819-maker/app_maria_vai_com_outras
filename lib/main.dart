import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/router/app_router.dart';
import 'core/firebase/firebase_service.dart';
import 'core/firebase/messaging_service.dart';
import 'core/theme/app_theme.dart';

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
      title: AppTheme.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(AppTheme.lightTheme.textTheme),
      ),
      darkTheme: AppTheme.darkTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(AppTheme.darkTheme.textTheme),
      ),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}