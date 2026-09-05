import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariavai_services/core/theme/app_theme.dart';
import 'package:mariavai_services/core/widgets/branding_logo_image.dart';

/// Versão MVP da tela de login - permite navegação simplificada
/// para demonstração sem autenticação Firebase
class LoginPageMVP extends StatefulWidget {
  const LoginPageMVP({super.key});

  @override
  State<LoginPageMVP> createState() => _LoginPageMVPState();
}

class _LoginPageMVPState extends State<LoginPageMVP> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // MVP: Login simplificado - permite navegar baseado no email
    final email = _emailController.text.trim().toLowerCase();

    String route = '/client';
    if (email.contains('admin')) {
      route = '/admin';
    } else if (email.contains('prestadora') || email.contains('provider') || email == 'prestador@teste.com') {
      route = '/provider';
    }

    if (mounted) {
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Responsive sizing - Forçando o 250 a ser double (.0) para sanar o erro de tipo 'num'
    final logoSize = (isMobile ? screenWidth * 0.6 : 250.0).toDouble();
    final titleFontSize = isMobile ? 22.0 : 28.0;
    final subtitleFontSize = isMobile ? 12.0 : 14.0;
    final sloganFontSize = isMobile ? 14.0 : 16.0;
    final horizontalPadding = isMobile ? 16.0 : 24.0;
    final verticalPadding = isMobile ? 16.0 : 32.0;

    return Scaffold(
      backgroundColor: AppTheme.primaryPink,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: isMobile ? 10 : 20),
                  BrandingLogoImage(size: logoSize),
                  SizedBox(height: isMobile ? 16 : 32),
                  Text(
                    AppTheme.appName,
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppTheme.appName2,
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 8 : 16),
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: sloganFontSize,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 16 : 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: AppTheme.primaryWhite,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 12 : 16,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      if (!value.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: AppTheme.primaryWhite,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 12 : 16,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isMobile ? 16 : 24),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 14 : 16,
                      ),
                      backgroundColor: AppTheme.primaryBlack,
                      foregroundColor: AppTheme.primaryWhite,
                    ),
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: isMobile ? 14 : 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 4 : 8),
                  const Divider(),
                  SizedBox(height: isMobile ? 4 : 8),
                  Text(
                    'Ainda não tem conta?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  SizedBox(height: isMobile ? 6 : 8),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/register/client'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 14 : 16,
                      ),
                      foregroundColor: AppTheme.primaryBlack,
                      side: const BorderSide(color: AppTheme.primaryBlack),
                    ),
                    icon: const Icon(Icons.person_add),
                    label: Text(
                      'Cadastrar como cliente',
                      style: TextStyle(fontSize: isMobile ? 14 : 16),
                    ),
                  ),
                  SizedBox(height: isMobile ? 6 : 8),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/register/provider'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 14 : 16,
                      ),
                      foregroundColor: AppTheme.primaryBlack,
                      side: const BorderSide(color: AppTheme.primaryBlack),
                    ),
                    icon: const Icon(Icons.home_repair_service),
                    label: Text(
                      'Cadastrar como prestadora',
                      style: TextStyle(fontSize: isMobile ? 14 : 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
