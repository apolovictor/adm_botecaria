import 'package:get_it/get_it.dart';

import 'modules/auth/repository/auth_repository.dart';
import 'modules/auth/services/auth_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register my services
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  // Register my concrete repositories

  // Register my abstraction repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthService>()),
  );

  // getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}
