import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/features/auth/login_page_mvp.dart';
import '../../presentation/features/client/client_home_page.dart';
import '../../presentation/features/provider/provider_home_page.dart';
import '../../presentation/features/admin/admin_dashboard_page.dart';
import '../../presentation/features/panic/panic_button_page.dart';
import '../../presentation/features/chat/chat_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPageMVP(),
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
  ],
);