import 'package:adm_botecaria/modules/home/models/unidades_de_medida_model.dart';
import 'package:asp/asp.dart';

import '../../../setup_locator.dart';
import '../models/category_model.dart';
import '../repositories/category_repository.dart';
import '../repositories/unidades_de_medidas_repository.dart';
import '../services/category_services.dart';
import '../services/unidades_de_medidas_services.dart';
import 'actions.dart';

final getCategoriesSelector = selector((get) {
  final CategoryRepository categoryRepository = CategoryRepository(
    getIt<CategoryService>(),
  );
  final categoriesStream = categoryRepository.getCategoriesStream().map(
    (snapshot) => snapshot.docs.map((doc) => Categories.fromDoc(doc)).toList(),
  );

  categoriesStream.listen((categories) {
    // debugPrint("categories === $categories");

    addCategoriesToListAction(categories);
  });
});
final getUnidadesDeMedidaSelector = selector((get) {
  final UnidadesDeMedidasRepository unidadesDeMedidasRepository =
      UnidadesDeMedidasRepository(getIt<UnidadesDeMedidasRService>());

  final unidadesDeMedidaStream = unidadesDeMedidasRepository
      .getUnidadesDeMedidaStream()
      .map(
        (snapshot) =>
            snapshot.docs
                .map((doc) => UnidadesDeMedidaModel.fromDoc(doc))
                .toList(),
      );

  unidadesDeMedidaStream.listen((unidadesDeMedida) {
    // debugPrint("unidadesDeMedida === $unidadesDeMedida");

    addUnidadesDeMedidaToListAction(unidadesDeMedida);
  });
});
