import 'package:go_router/go_router.dart';
import '../../presentation/features/auth/login_page.dart';
import '../../presentation/features/auth/register_page.dart';
import '../../domain/entities/user.dart';
import '../../presentation/features/client/client_home_page.dart';
import '../../presentation/features/provider/provider_home_page.dart';
import '../../presentation/features/admin/admin_dashboard_page.dart';
import '../../presentation/features/panic/panic_button_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register/client',
      name: 'register_client',
      builder: (context, state) => const RegisterPage(role: UserRole.client),
    ),
    GoRoute(
      path: '/register/provider',
      name: 'register_provider',
      builder: (context, state) => const RegisterPage(role: UserRole.provider),
    ),
    GoRoute(
      path: '/register/admin',
      name: 'register_admin',
      builder: (context, state) => const RegisterPage(role: UserRole.admin),
    ),
    GoRoute(
      path: '/client',
      name: 'client_home',
      builder: (context, state) => const ClientHomePage(),
    ),
    GoRoute(
      path: '/provider',
      name: 'provider_home',
      builder: (context, state) => const ProviderHomePage(),
    ),
    GoRoute(
      path: '/admin',
      name: 'admin_dashboard',
      builder: (context, state) => const AdminDashboardPage(),
    ),
    GoRoute(
      path: '/panic',
      name: 'panic',
      builder: (context, state) => const PanicButtonPage(),
    ),
  ],
);