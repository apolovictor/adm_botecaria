import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // Import hooks
import 'package:go_router/go_router.dart'; // Import go_router
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/helpers/firebase_errors.dart';
import '../../../shared/helpers/validators.dart';
import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../providers/states/forgot_password_states.dart';
import 'widgets/auth_login_screen_text_field.dart';

final formKey = GlobalKey<FormState>();

class ForgotPasswordPage extends StatelessWidget with HookMixin {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final emailController = useTextEditingController();
    final passwordState = useAtomState(passwordStateAtom);

    // final formKey = useMemoized(() => GlobalKey<FormState>(), [
    //   GoRouter.of(context).state!.uri,
    // ]);
    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     passwordController.startPage();
    //   });
    //   return null; // Cleanup (timer is already cancelled in dispose)
    // }, []);

    final width =
        MediaQuery.of(context).size.width > 700
            ? MediaQuery.of(context).size.width * 0.50
            : MediaQuery.of(context).size.width;

    if (passwordState is ForgotPasswordSent && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                'Verifique o link que foi enviado para o seu e-mail e retorne ao aplicativo para acessá-lo novamente',
              ),
              actions: [
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    context.pop();
                  },
                ),
                TextButton(
                  child: const Text('Login'),
                  onPressed: () {
                    setInitialForgotPasswordAction();
                    context.pop();
                    context.pop();
                    // context.go('/login?register=false');
                  },
                ),
              ],
            );
          },
        );
      });
    }
    return Form(
      key: formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Coloque seu email para enviarmos link de recuperação',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 25),
                  getTextField(
                    context: context,
                    focusNodeCurrent:
                        FocusNode(), // You might want to manage focus if you have other fields
                    focusNodeNext: FocusNode(),
                    labelText: "E-mail",
                    obsectextType: false,
                    textType: TextInputType.emailAddress,
                    enablefield: true,
                    validator: emailValidator, // Use your email validator
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      minimumSize: const Size.fromHeight(60),
                    ),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      context.go('/login?register=false');
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      minimumSize: const Size.fromHeight(60),
                    ),
                    onPressed:
                        passwordState is ForgotPasswordLoading
                            ? null
                            : () async {
                              if (formKey.currentState!.validate()) {
                                // await forgotPasswordAction(
                                //   emailController.text.trim(),
                                // );
                              }
                            },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
