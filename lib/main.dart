import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'modules/auth/asp/actions.dart';
import 'modules/auth/providers/router_provider.dart';
import 'setup_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupLocator();

  runApp(const ProviderScope(child: MyApp())); // runApp *inside* the zone
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    FirebaseAuth.instance
        .authStateChanges()
        .listen((user) {
          if (user != null) {
            setLoginStateSuccessAction();
          } else {
            setLoginStateInitialAction();
          }
        })
        .onError((error) {
          // Error Handling
          // state = AuthState.error(error.toString()); // Set error state
          debugPrint("Firebase Auth State Error: $error");
        });
    return MaterialApp.router(
      routerConfig: router, // Correct way to provide the router
      title: 'Adm Botecaria',
      debugShowCheckedModeBanner: false,
      // ... other MaterialApp properties
      // builder: (context, child) {
      //   // Builder to ensure ScaffoldMessenger is available
      //   return Scaffold(
      //     backgroundColor: Colors.amber,
      //     // The Scaffold is crucial for SnackBar display
      //     body: child,
      //     // SizedBox(
      //     //   height: MediaQuery.of(context).size.height,
      //     //   width: MediaQuery.of(context).size.width,
      //     //   child: Stack(children: [child ?? SizedBox()]),
      //     // ),
      //   );
      // },
    );
  }
}
