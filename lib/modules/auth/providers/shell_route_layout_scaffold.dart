import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../asp/actions.dart';
import '../asp/atoms.dart';
import 'states/login_states.dart';

class LayoutScaffold extends StatelessWidget with HookMixin {
  const LayoutScaffold({
    super.key,
    required this.child,
    required this.goRouterState,
  });

  final Widget child;

  final GoRouterState goRouterState;

  @override
  Widget build(BuildContext context) {
    final authState = useAtomState(loginStateAtom);
    return Material(
      color: Colors.white.withOpacity(0.2),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar:
                authState is LoginStateSuccess
                    ? AppBar(
                      title:
                          goRouterState.uri.path == '/productRegister'
                              ? const Text('Cadastrar Produto')
                              : const Text('Botecaria'),
                      centerTitle: true,
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            logoutAction();
                            // ref.read(authControllerProvider.notifier).logout();
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ],
                    )
                    : AppBar(),
            body: AtomBuilder(
              builder: (_, get) {
                if (authState is LoginStateSuccess) {}

                return child;
              },
            ),
            floatingActionButton:
                goRouterState.uri.path == '/home'
                    ? FloatingActionButton(
                      onPressed: () {
                        context.go('/productRegister');
                      },
                      backgroundColor: Colors.black87,
                      child: Icon(Icons.add, color: Colors.white),
                    )
                    : SizedBox(),
          ),
        ],
      ),
    );
  }
}
