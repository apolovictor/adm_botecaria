import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../common/helpers/auth_validators.dart';
import '../providers/states/login_states.dart';
import 'widgets/auth_login_sreen_password_field.dart';
import 'widgets/auth_login_screen_text_field.dart';

// 2. LoginPage (UI)

final formLoginKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget with HookMixin {
  // Use HookConsumerWidget
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final emailController = useTextEditingController();
    // final passwordController = useTextEditingController();
    final loginState = useAtomState(loginStateAtom);
    // final authStateProvider = ref.watch(authControllerProvider.notifier);

    final focusNodes = List.generate(2, (_) => FocusNode());

    return Center(
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width > 700
                ? MediaQuery.of(context).size.width * 0.50
                : MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formLoginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getTextField(
                  context: context,
                  focusNodeCurrent: focusNodes[0],
                  focusNodeNext: focusNodes[1],
                  labelText: "E-mail",
                  obsectextType: false,
                  textType: TextInputType.emailAddress,
                  enablefield: true,
                  validator: emailValidator,
                  // controller: emailController,
                ),
                const SizedBox(height: 10),
                passwordFieldWidget(
                  focusNodes[1],
                  "Senha",
                  context,
                  passwordValidator,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: const Size.fromHeight(60),
                  ),
                  onPressed:
                      (loginState is LoginStateLoading)
                          ? null
                          : () async {
                            formLoginKey.currentState!.validate()
                                ? await loginAction()
                                : null;
                          },
                  child:
                      // Text(
                      //   'Login',
                      //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      // ),
                      loginState is LoginStateLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                ),
                // TextButton(
                //   onPressed: () => context.go('/forgotPassword'),
                //   child: const Text('Esqueceu sua senha?'),
                // ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
