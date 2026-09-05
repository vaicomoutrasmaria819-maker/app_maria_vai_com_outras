import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/features/auth/login_page_mvp.dart';
import '../../presentation/features/auth/register_page.dart';
import '../../presentation/features/client/client_home_page.dart';
import '../../presentation/features/provider/provider_home_page.dart';
import '../../presentation/features/admin/admin_dashboard_page.dart';
import '../../presentation/features/panic/panic_button_page.dart';
import '../../presentation/features/chat/chat_page.dart';
import '../../presentation/features/rating/ratings_page.dart';
import '../../presentation/features/rating/create_rating_page.dart';
import '../../domain/entities/user.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPageMVP(),
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
    GoRoute(
      path: '/chat',
      name: 'chat',
      builder: (context, state) {
        final currentUserId = state.uri.queryParameters['currentUserId'] ?? 'client_1';
        final otherUserId = state.uri.queryParameters['otherUserId'] ?? 'provider_1';
        final otherUserName = state.uri.queryParameters['otherUserName'] ?? 'Prestadora';
        final serviceId = state.uri.queryParameters['serviceId'];
        
        return ChatPage(
          currentUserId: currentUserId,
          otherUserId: otherUserId,
          otherUserName: otherUserName,
          serviceId: serviceId,
        );
      },
    ),
    GoRoute(
      path: '/ratings',
      name: 'ratings',
      builder: (context, state) {
        final providerId = state.uri.queryParameters['providerId'];
        final providerName = state.uri.queryParameters['providerName'];
        final isAdminView = state.uri.queryParameters['isAdminView'] == 'true';
        
        return RatingsPage(
          providerId: providerId,
          providerName: providerName,
          isAdminView: isAdminView,
        );
      },
    ),
    GoRoute(
      path: '/create-rating',
      name: 'create_rating',
      builder: (context, state) {
        final serviceId = state.uri.queryParameters['serviceId'] ?? '';
        final providerId = state.uri.queryParameters['providerId'] ?? '';
        final providerName = state.uri.queryParameters['providerName'] ?? 'Prestadora';
        final serviceTitle = state.uri.queryParameters['serviceTitle'] ?? 'Serviço';
        
        return CreateRatingPage(
          serviceId: serviceId,
          providerId: providerId,
          providerName: providerName,
          serviceTitle: serviceTitle,
        );
      },
    ),
  ],
);