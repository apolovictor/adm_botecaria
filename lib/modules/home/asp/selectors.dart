import 'package:adm_botecaria/modules/home/models/gpc_model.dart';
import 'package:adm_botecaria/modules/home/models/unidades_de_medida_model.dart';
import 'package:adm_botecaria/modules/home/providers/states/product_states.dart';
import 'package:asp/asp.dart';

import '../../../setup_locator.dart';
import '../models/category_model.dart';
import '../models/manufacturers_model.dart';
import '../models/products_model.dart';
import '../repositories/category_repository.dart';
import '../repositories/gpc_repository.dart';
import '../repositories/manufacturers_repository.dart';
import '../repositories/product_repository.dart';
import '../repositories/unidades_de_medidas_repository.dart';
import '../services/category_services.dart';
import '../services/gpc_services.dart';
import '../services/manufacturers_services.dart';
import '../services/product_services.dart';
import '../services/unidades_de_medidas_services.dart';
import 'actions.dart';
import 'atoms.dart';

final getCategoriesSelector = selector((get) {
  final CategoryRepository categoryRepository = CategoryRepository(
    getIt<CategoryService>(),
  );
  final categoriesStream = categoryRepository.getCategoriesStream().map(
    (snapshot) => snapshot.docs.map((doc) => Categories.fromDoc(doc)).toList(),
  );

  categoriesStream.listen((categories) {
    addCategoriesToListAction(categories);
  });
});

final getUnidadesDeMedidaSelector = selector((get) {
  final UnidadesDeMedidasRepository unidadesDeMedidasRepository =
      UnidadesDeMedidasRepository(getIt<UnidadesDeMedidasService>());

  final unidadesDeMedidaStream = unidadesDeMedidasRepository
      .getUnidadesDeMedidaStream()
      .map(
        (snapshot) =>
            snapshot.docs
                .map((doc) => UnidadesDeMedidaModel.fromDoc(doc))
                .toList(),
      );

  unidadesDeMedidaStream.listen((unidadesDeMedida) {
    addUnidadesDeMedidaToListAction(unidadesDeMedida);
  });
});

final getManufacturersSelector = selector((get) {
  final ManufacturersRepository manufacturersRepository =
      ManufacturersRepository(getIt<ManufacturersServices>());

  final manufacturersStream = manufacturersRepository
      .getManufacturersStream()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => Manufacturer.fromDoc(doc)).toList(),
      );

  var filter = get(filterManufacturersAtom);

  // if (double.tryParse(filter) == null) {
  //   filter = filter.toLowerCase();
  // }

  manufacturersStream.listen((manufactures) {
    if (filter == null || filter.isEmpty) {
      addManufacturersToListAction(manufactures);
    } else {
      final filteredResult =
          manufactures.where((manufacturer) {
            bool foundMatch = false;

            if (double.tryParse(filter) == null) {
              // Check if the name contains the search term (case-insensitive)
              if (manufacturer.name.toLowerCase().contains(filter)) {
                foundMatch = true;
              }
            }

            // Check if the CNPJ list contains the search term
            for (var cnpjPart in manufacturer.cnpj) {
              if (cnpjPart.toString().contains(filter)) {
                foundMatch = true;
                break;
              }
            }

            return foundMatch;
          }).toList();
      addManufacturersToListAction(filteredResult);
    }
  });
});

final getGpcFamilySelector = selector((get) {
  final GpcRepository gpcRepository = GpcRepository(getIt<GpcService>());
  final gpcFamilyStream = gpcRepository.getGpcFamilyStream().map(
    (snapshot) =>
        snapshot.docs.map((doc) => GpcFamilyModel.fromDoc(doc)).toList(),
  );

  gpcFamilyStream.listen((gpcFamily) {
    addGpcFamilyToListAction(gpcFamily);
  });
});

final getGpcClassSelector = selector((get) {
  final GpcRepository gpcRepository = GpcRepository(getIt<GpcService>());
  final gpcFamilySelected = get(gpcFamilySelectedAtom);
  final classStream = gpcRepository
      .getGpcClassStream(gpcFamilySelected!)
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => GpcClassModel.fromDoc(doc)).toList(),
      );

  classStream.listen((gpcClass) {
    addGpcClassToListAction(gpcClass);
  });
});

final getGpcBrickSelector = selector((get) {
  final GpcRepository gpcRepository = GpcRepository(getIt<GpcService>());
  final gpcFamilySelected = get(gpcFamilySelectedAtom);
  final gpcClassSelected = get(gpcClassSelectedAtom);

  final bricksStream = gpcRepository
      .getGpcBrickStream(gpcFamilySelected!, gpcClassSelected!)
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => GpcBrickModel.fromDoc(doc)).toList(),
      );

  bricksStream.listen((gpcBrick) {
    addGpcBrickToListAction(gpcBrick);
  });
});

final getAdmProductsSelector = selector((get) {
  final ProductRepository productRepository = ProductRepository(
    getIt<ProductServices>(),
  );

  final productStream = productRepository.getAdmProducts().map(
    (snapshot) => snapshot.docs.map((doc) => Product.fromDoc(doc)).toList(),
  );

  final response = productStream.listen((products) {
    print("products.length ===== ${products.length}");
    addProductstoAtomListAction(products);
  });

  print("response ===== ${response}");
});
