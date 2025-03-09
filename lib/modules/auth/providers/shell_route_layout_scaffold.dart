import 'package:adm_botecaria/modules/home/providers/states/product_states.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/overlay_snackbar.dart';
import '../../home/asp/actions.dart';
import '../../home/asp/atoms.dart';
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
    final productState = useAtomState(productStateAtom);

    if (authState is LoginStateError) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showOverlaySnackbar(context, authState.errorMessage);
      });
    }
    if (productState is ProductStatusStateAdded) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
        showOverlaySnackbar(context, 'Produto adicionado com sucesso!');
      });
    }
    if (productState is ProductStatusStateAddingError) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
        showOverlaySnackbar(context, productState.errorMessage);
      });
    }

    return Material(
      color: Colors.white.withValues(alpha: 0.2),
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
                              : goRouterState.uri.path == '/detailProduct'
                              ? const Text('Detalhes do Produto')
                              : const Text('Botecaria'),
                      centerTitle: true,
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      leading:
                          goRouterState.uri.path == '/detailProduct'
                              ? IconButton(
                                onPressed: () {
                                  setSelectedProductAction(null);
                                  context.go('/home');
                                  // Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back),
                              )
                              : SizedBox(),
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
