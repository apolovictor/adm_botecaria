import 'package:get_it/get_it.dart';

import 'modules/auth/repository/auth_repository.dart';
import 'modules/auth/services/auth_service.dart';
import 'modules/home/repositories/category_repository.dart';
import 'modules/home/services/category_services.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register my services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<CategoryService>(() => CategoryService());

  // Register my concrete repositories

  // Register my abstraction repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthService>()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(getIt<CategoryService>()),
  );

  // getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}
