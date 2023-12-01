import 'package:chat/global/di.dart';
import 'package:chat/global/provider_wrapper.dart';
import 'package:chat/models/user.dart';
import 'package:chat/pages/pages.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter routerConfig = GoRouter(
    initialLocation: '/user',
    redirect: (context, state) {
      bool isLoggedIn = context.read<AuthService>().session.isActive;
      if (!isLoggedIn) {
        if (state.uri.path == '/register') {
          return '/register';
        } else {
          return '/';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/user',
        builder: (context, state) => const UserPage(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => ProviderWrapper(
          provider: getIt<ChatService>(),
          child: ChatPage(user: state.extra as User),
        ),
      ),
    ],
  );
}
