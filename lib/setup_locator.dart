import 'package:get_it/get_it.dart';

import 'modules/auth/repository/auth_repository.dart';
import 'modules/auth/services/auth_service.dart';
import 'modules/home/repositories/category_repository.dart';
import 'modules/home/repositories/unidades_de_medidas_repository.dart';
import 'modules/home/services/category_services.dart';
import 'modules/home/services/unidades_de_medidas_services.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register my services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<CategoryService>(() => CategoryService());
  getIt.registerLazySingleton<UnidadesDeMedidasRService>(
    () => UnidadesDeMedidasRService(),
  );

  // Register my concrete repositories

  // Register my abstraction repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthService>()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(getIt<CategoryService>()),
  );
  getIt.registerLazySingleton<UnidadesDeMedidasRepository>(
    () => UnidadesDeMedidasRepository(getIt<UnidadesDeMedidasRService>()),
  );

  // getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}
