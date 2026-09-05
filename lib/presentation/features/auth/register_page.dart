import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariavai_services/core/theme/app_theme.dart';
import 'package:mariavai_services/core/widgets/branding_logo_image.dart';
// import 'package:mariavai_services/core/firebase/auth_service.dart';
// import 'package:mariavai_services/core/firebase/firestore_service.dart';
import 'package:mariavai_services/domain/entities/user.dart' as domain;

/// Tela de cadastro compartilhada para os três papéis do app (cliente,
/// prestadora, admin). O papel define título, ícone, o campo extra de
/// código de acesso (admin) e para onde o usuário é enviado após criar
/// a conta.
class RegisterPage extends StatefulWidget {
  final domain.UserRole role;

  const RegisterPage({super.key, required this.role});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _accessCodeController = TextEditingController();

  // MVP: Firebase desabilitado
  // final _authService = AuthService();
  // final _firestoreService = FirestoreService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  // O código de acesso de admin agora é validado no servidor (Cloud
  // Function `registerUser`, via configuração segura), não mais aqui no
  // app — evita que qualquer pessoa veja o código lendo o código-fonte
  // compilado do app.

  String get _title {
    switch (widget.role) {
      case domain.UserRole.client:
        return 'Criar conta de cliente';
      case domain.UserRole.provider:
        return 'Criar conta de prestadora';
      case domain.UserRole.admin:
        return 'Criar conta de administrador';
    }
  }

  IconData get _icon {
    switch (widget.role) {
      case domain.UserRole.client:
        return Icons.person_add_alt_1_rounded;
      case domain.UserRole.provider:
        return Icons.home_repair_service_rounded;
      case domain.UserRole.admin:
        return Icons.admin_panel_settings_rounded;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _accessCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    // MVP: Navegação simplificada - apenas redireciona de volta para login
    // Em produção, usar Firebase Authentication e Firestore
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Responsive sizing
    final logoSize = (isMobile ? screenWidth * 0.5 : 200.0).toDouble();
    final titleFontSize = isMobile ? 20.0 : 24.0;
    final subtitleFontSize = isMobile ? 12.0 : 14.0;
    final padding = isMobile ? 16.0 : 24.0;
    final spacing = isMobile ? 12.0 : 16.0;
    final buttonPadding = isMobile ? 14.0 : 16.0;
    final inputPadding = isMobile ? 12.0 : 16.0;

    return Scaffold(
      backgroundColor: AppTheme.primaryPink,
      appBar: AppBar(
        title: Text(_title, style: TextStyle(fontSize: isMobile ? 18 : 20)),
        backgroundColor: AppTheme.primaryWhite,
        foregroundColor: AppTheme.primaryBlack,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: padding * 0.5,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: isMobile ? 10 : 20),
                  BrandingLogoImage(size: logoSize),
                  SizedBox(height: isMobile ? 16 : 24),
                  Text(
                    AppTheme.appName,
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppTheme.appName2,
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 8 : 16),
                  Text(
                    _title,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 16.0 : 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing * 1.5),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome completo',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: AppTheme.primaryWhite,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: inputPadding,
                        vertical: inputPadding,
                      ),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Informe seu nome'
                        : null,
                  ),
                  SizedBox(height: spacing),
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
                        horizontal: inputPadding,
                        vertical: inputPadding,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe seu email';
                      }
                      if (!value.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spacing),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Telefone (com DDD)',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: AppTheme.primaryWhite,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: inputPadding,
                        vertical: inputPadding,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Informe seu telefone'
                        : null,
                  ),
                  SizedBox(height: spacing),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: AppTheme.primaryWhite,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: inputPadding,
                        vertical: inputPadding,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe uma senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spacing),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: AppTheme.primaryWhite,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: inputPadding,
                        vertical: inputPadding,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  if (widget.role == domain.UserRole.admin) ...[
                    SizedBox(height: spacing),
                    TextFormField(
                      controller: _accessCodeController,
                      decoration: InputDecoration(
                        labelText: 'Código de acesso administrativo',
                        prefixIcon: const Icon(Icons.vpn_key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: AppTheme.primaryWhite,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: inputPadding,
                          vertical: inputPadding,
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? 'Informe o código de acesso'
                          : null,
                    ),
                  ],
                  if (_errorMessage != null) ...[
                    SizedBox(height: spacing),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: spacing * 1.5),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: buttonPadding),
                      backgroundColor: AppTheme.primaryBlack,
                      foregroundColor: AppTheme.primaryWhite,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Criar conta',
                            style: TextStyle(fontSize: isMobile ? 14 : 16),
                          ),
                  ),
                  SizedBox(height: spacing),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Já tem conta? Entrar',
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
