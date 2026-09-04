import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/router/app_router.dart';
// import 'core/firebase/firebase_service.dart';
// import 'core/firebase/messaging_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // MVP: Firebase desabilitado para demo rápida
  // await FirebaseService.initialize();
  // await MessagingService().initialize();

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