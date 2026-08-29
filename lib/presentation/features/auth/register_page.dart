import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariavai_services/core/firebase/auth_service.dart';
import 'package:mariavai_services/core/firebase/firestore_service.dart';
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

  final _authService = AuthService();

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

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.registerWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        role: widget.role,
        adminAccessCode: widget.role == domain.UserRole.admin
            ? _accessCodeController.text.trim()
            : null,
      );

      if (!mounted) return;

      switch (widget.role) {
        case domain.UserRole.client:
          context.go('/client');
          break;
        case domain.UserRole.provider:
          context.go('/provider');
          break;
        case domain.UserRole.admin:
          context.go('/admin');
          break;
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao criar conta: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(_icon, size: 64, color: primary),
                  const SizedBox(height: 16),
                  Text(
                    _title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome completo',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Informe seu nome'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Telefone (com DDD)',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Informe seu telefone'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(() =>
                            _obscureConfirmPassword = !_obscureConfirmPassword),
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _accessCodeController,
                      decoration: const InputDecoration(
                        labelText: 'Código de acesso administrativo',
                        prefixIcon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.trim().isEmpty)
                          ? 'Informe o código de acesso'
                          : null,
                    ),
                  ],
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Criar conta', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Já tem conta? Entrar'),
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
