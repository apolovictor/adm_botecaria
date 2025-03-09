import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../home/ui/home_screen.dart';
import '../../home/ui/product_register.dart';
import '../asp/atoms.dart';
import '../ui/login_screen.dart';
import 'shell_route_layout_scaffold.dart';
import 'states/login_states.dart';

enum AppRoutes {
  home,
  productRegister;

  String get path {
    switch (this) {
      case AppRoutes.home:
        return '/home';
      case AppRoutes.productRegister:
        return '/productRegister';
    }
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier();

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogic,
    routes: router._routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  // final Ref _ref;

  RouterNotifier() {
    loginStateAtom.addListener(() => notifyListeners());
  }

  String? _redirectLogic(context, GoRouterState state) {
    final loginState = loginStateAtom.state;
    if (loginState is LoginStateInitial) {
      return getUnauthenticatedAppRoutes(state.uri.path);
    } else if (loginState is LoginStateSuccess) {
      return getAuthenticatedAppRoutes(state.uri.path);
    }

    return null;
    // return '/splashScreen';
  }

  List<RouteBase> get _routes => [
    ShellRoute(
      // Use a ShellRoute
      builder: (context, state, child) {
        //Wrap your content in a Scaffold with a potential message display
        return LayoutScaffold(goRouterState: state, child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: 'login',
          pageBuilder:
              (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const LoginPage(),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0), // Start from right
                      end: Offset.zero,
                    ).animate(animation),
                    child: SlideTransition(
                      // Animate outgoing page
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(1.0, 0.0), // Outgoing to left
                      ).animate(secondaryAnimation),
                      child: child,
                    ),
                  );
                },
              ),
        ),
        GoRoute(
          path: AppRoutes.home.path,
          name: 'home',
          pageBuilder:
              (context, state) => _buildTransitionPage(
                context: context,
                state: state,
                child: const HomePage(),
              ),
        ),

        GoRoute(
          name: 'productRegister',
          path: '/productRegister',
          builder: (context, state) => const ProductRegister(),
        ),
        // GoRoute(
        //   path: AppRoutes.detailsProduct.path,
        //   name: 'detailsProduct',
        //   pageBuilder: (context, state) {
        //     return _buildTransitionPage(
        //       context: context,
        //       state: state,
        //       child: const DetailProductPage(),
        //     );
        //   },
        // ),
        // GoRoute(
        //   path: AppRoutes.tabs.path,
        //   pageBuilder:
        //       (context, state) => _buildTransitionPage(
        //         context: context,
        //         state: state,
        //         child: const TablesPage(),
        //       ),
        // ),
      ],
    ),
  ];
}

CustomTransitionPage<void> _buildTransitionPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  final currentLocation = state.fullPath;
  final nextIndex = AppRoutes.values.indexWhere(
    (route) => route.path == currentLocation,
  );

  final effectiveNextIndex = nextIndex;

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin =
          (effectiveNextIndex ==
                  nextIndex) // Simplify transition logic.  Correct usage of ternary operator.
              ? const Offset(1.0, 0.0) // Slide from right if going forward
              : const Offset(-1.0, 0.0);

      var end = Offset.zero;

      var tween = Tween(begin: begin, end: end);

      var offsetAnimation = animation.drive(tween);

      final outgoingTween = Tween(begin: Offset.zero, end: -begin).chain(
        CurveTween(curve: Curves.easeInOut),
      ); // For outgoing page (-begin for opposite direction)
      final outgoingAnimation = secondaryAnimation.drive(outgoingTween);

      return SlideTransition(
        position: offsetAnimation,
        child: SlideTransition(
          // Animate outgoing page
          position: outgoingAnimation,
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(
      milliseconds: 150,
    ), // Set duration here!!
    reverseTransitionDuration: const Duration(milliseconds: 150),
  );
}

String getAuthenticatedAppRoutes(String route) {
  switch (route) {
    case '/home':
      return AppRoutes.home.path;
    case '/productRegister':
      return AppRoutes.productRegister.path;
    default:
      return AppRoutes.home.path;
  }
}

String getUnauthenticatedAppRoutes(String route) {
  switch (route) {
    case '/':
      return '/';
    case '/forgotPassword':
      return '/forgotPassword';
    default:
      return '/';
  }
}
