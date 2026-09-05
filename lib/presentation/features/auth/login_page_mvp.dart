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
    } else if (email.contains('prestadora') || email.contains('provider')) {
      route = '/provider';
    }

    if (mounted) {
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryPink,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const BrandingLogoImage(size: 250),
                  const SizedBox(height: 32),
                  Text(
                    AppTheme.appName,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppTheme.appName2,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlack,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      AppTheme.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppTheme.slogan,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
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
                  const SizedBox(height: 16),
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
                    ),
                    obscureText: true,
                    // MVP: Senha não é validada
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppTheme.primaryBlack,
                      foregroundColor: AppTheme.primaryWhite,
                    ),
                    child: const Text('Entrar', style: TextStyle(fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: const Text('Esqueceu a senha?'),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    'Ainda não tem conta?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/register/client'),
                    icon: const Icon(Icons.person_add_alt_1_rounded),
                    label: const Text('Cadastrar como cliente'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/register/provider'),
                    icon: const Icon(Icons.home_repair_service_rounded),
                    label: const Text('Cadastrar como prestadora'),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => context.push('/register/admin'),
                      child: Text(
                        'Acesso administrativo',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
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
