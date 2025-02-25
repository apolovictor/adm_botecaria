import 'package:asp/asp.dart';

import '../../../setup_locator.dart';
import '../models/category_model.dart';
import '../repositories/category_repository.dart';
import '../services/category_services.dart';
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
