import 'dart:typed_data';
import 'package:adm_botecaria/modules/home/models/gpc_model.dart';
import 'package:adm_botecaria/modules/home/models/products_model.dart';
import 'package:asp/asp.dart';
import '../../../setup_locator.dart';
import '../interactor/update_image_product_interactor.dart';
import '../models/category_model.dart';
import '../models/manufacturers_model.dart';
import '../models/unidades_de_medida_model.dart';
import '../providers/states/detail_product_states.dart';
import '../providers/states/product_states.dart';
import '../repositories/product_repository.dart';
import '../services/product_services.dart';
import 'atoms.dart';

// Actions para modificar os átomos dos campos de produto
final setProductImageAction = atomAction1<Uint8List>((set, image) {
  set(selectedImageState, image);
});
final clearProductImageAction = atomAction((set) {
  set(selectedImageState, null);
});
final setProductCodeAction = atomAction1<String>((set, value) {
  set(productCodeAtom, value);
});
final setProductEanAction = atomAction1<double?>((set, value) {
  set(productEanAtom, value);
});
final setProductNameAction = atomAction1<String>((set, value) {
  set(productNameAtom, value);
});
final setProductNCMAction = atomAction1<double?>((set, value) {
  set(productNCMAtom, value);
});

final setProductCategoriaAction = atomAction1<Categories>((set, value) {
  set(productCategoryaAtom, value);
});
final setProductUComAction = atomAction1<String>((set, value) {
  set(productUComAtom, value);
});
final setProductMarcaAction = atomAction1<String>((set, value) {
  set(productManufacturerBrandAtom, value);
});
final setProductCNPJFabAction = atomAction1<String>((set, value) {
  set(productCNPJFabAtom, value);
});
final setProductCESTAction = atomAction1<double?>((set, value) {
  set(productCESTAtom, value);
});
final setProductAverageSellPriceAction = atomAction1<String>((set, value) {
  set(productPrecoMedioVendaAtom, value);
});
final setProductAverageUnitPriceAction = atomAction1<String>((set, value) {
  set(productPrecoMedioUnitarioAtom, value);
});
final setProductDesciptionAction = atomAction1<String>((set, value) {
  set(productDescriptionAtom, value);
});

final setPositionFloatingButtonAction = atomAction1<bool>((set, value) {
  set(isPositionFloatingButtonAtom, value);
});

final addCategoriesToListAction = atomAction1<List<Categories>>((
  set,
  categories,
) {
  set(categoriesListAtom, [...categories]);
});

final addUnidadesDeMedidaToListAction =
    atomAction1<List<UnidadesDeMedidaModel>>((set, unidadesDeMedida) {
      set(unidadesDeMeddidaListAtom, [...unidadesDeMedida]);
    });

final addManufacturersToListAction = atomAction1<List<Manufacturer>>((
  set,
  manufacturers,
) {
  set(filteredManufacturersListAtom, [...manufacturers]);
});
final filterManufacturerAction = atomAction1<dynamic>((set, filter) {
  set(filterManufacturersAtom, filter);
});

final setSelectedManufacturerAction = atomAction1<Manufacturer>((
  set,
  selected,
) {
  set(selectedManufacturersAtom, selected);
});
final clearSelectedManufacturerAndFilterAction = atomAction((set) {
  set(selectedManufacturersAtom, null);
  set(filterManufacturersAtom, null);
});

final addGpcFamilyToListAction = atomAction1<List<GpcFamilyModel>>((
  set,
  gpcFamily,
) {
  set(gpcFamilyListAtom, [...gpcFamily]);
});

final addGpcClassToListAction = atomAction1<List<GpcClassModel>>((
  set,
  gpcClass,
) {
  set(gpcClassListAtom, [...gpcClass]);
});
final addGpcBrickToListAction = atomAction1<List<GpcBrickModel>>((
  set,
  gpcBrick,
) {
  set(gpcBrickListAtom, [...gpcBrick]);
});

final setGpcFamilySelectedAction = atomAction1<GpcFamilyModel>((set, value) {
  set(gpcFamilySelectedAtom, value);
});

final setGpcClassSelectedAction = atomAction1<GpcClassModel>((set, value) {
  set(gpcBrickSelectedAtom, null);
  gpcBrickListAtom.state.clear();
  set(gpcBrickListAtom, [...gpcBrickListAtom.state]);
  set(gpcClassSelectedAtom, value);
});

final setGpcBrickSelectedAction = atomAction1<GpcBrickModel>((set, value) {
  set(gpcBrickSelectedAtom, value);
});

final addProductAction = atomAction((set) async {
  setProductStateAction(ProductStatusStateLoadingAdding());

  final ProductRepository productRepository = ProductRepository(
    getIt<ProductServices>(),
  );

  double? productPrecoMedioUnitario = double.tryParse(
    productPrecoMedioUnitarioAtom.state.replaceAll(',', '.'),
  );
  double? productPrecoMedioVenda = double.tryParse(
    productPrecoMedioVendaAtom.state.replaceAll(',', '.'),
  );

  final product = Product(
    cProd: productCodeAtom.state.toUpperCase().trim(),
    cEAN: productEanAtom.state,
    xProd: productNameAtom.state.toUpperCase().trim(),
    NCM: productNCMAtom.state,
    gpcFamilyCode: gpcFamilySelectedAtom.state?.familyCode,
    gpcFamilyDescription: gpcFamilySelectedAtom.state?.familyDescription.trim(),
    gpcClassCode: gpcClassSelectedAtom.state?.classCode,
    gpcClassDescription: gpcClassSelectedAtom.state?.classDescription.trim(),
    gpcBrickCode: gpcBrickSelectedAtom.state?.brickCode,
    gpcBrickDescription: gpcBrickSelectedAtom.state?.brickDescription.trim(),
    gpcBrickDefinition: gpcBrickSelectedAtom.state?.brickDefinition.trim(),
    category: productCategoryaAtom.state.documentId,
    categoryName: productCategoryaAtom.state.iconName,
    uCom: productUComAtom.state.trim(),
    imageUrl: null,
    manufacturerBrand: selectedManufacturersAtom.state?.name.trim(),
    CNPJFab: selectedManufacturersAtom.state?.cnpj,
    manufacturerImageUrl: selectedManufacturersAtom.state?.imageUrl,
    CEST: productCESTAtom.state,
    precoMedioUnitario: productPrecoMedioUnitario,
    precoMedioVenda: productPrecoMedioVenda,
    description: productDescriptionAtom.state.trim(),
  );

  try {
    await productRepository.addProduct(product, selectedImageState.state);
    setProductStateAction(ProductStatusStateAdded());
  } catch (e) {
    setProductStateAction(ProductStatusStateAddingError(e.toString()));
  }
});

final setProductStateAction = atomAction1<ProductStatusState>((set, value) {
  set(productStateAtom, value);
});

final addProductstoAtomListAction = atomAction1<List<Product>>((set, products) {
  set(productListAtom, [...products]);
});

final removeItemOfProductListAction = atomAction1<Product>((set, product) {
  set(productListAtom, [...productListAtom.state.where((e) => e != product)]);
});

final setSelectedCardAction = atomAction1<int>((set, index) {
  set(selectedCardAtom, index);
});

final setSelectedProductAction = atomAction1<Product?>((set, product) {
  set(selectedProductAtom, product);
});

final setDetailProductImage = atomAction1<Uint8List>((set, image) {
  set(selectedImageOfDetailProductState, image);
});

final clearDetailProductImageAction = atomAction((set) {
  set(selectedImageOfDetailProductState, null);
});

final updateImageOfProductAction = atomAction2<Product, Uint8List>((
  set,
  product,
  productImage,
) async {
  set(detailProductStateAtom, const DetailProductStates.loading());

  final UpdateImageProductInteractor updateImageProductInteractor =
      UpdateImageProductInteractor(getIt<ProductRepository>());

  try {
    final response = await updateImageProductInteractor.execute(
      product,
      productImage,
    );

    product = product.copyWith(imageUrl: response);

    setSelectedProductAction(product);
    set(
      detailProductStateAtom,
      const DetailProductStates.success('Imagem adicionada com sucesso'),
    );
  } catch (e) {
    set(detailProductStateAtom, DetailProductStates.error(e.toString()));
  }
});

final setDetailProductStateInitialAction = atomAction((set) {
  set(detailProductStateAtom, DetailProductStatesInitial());
});

//UPDATE ACTIONS

final updateProductAverageUnitPriceAction = atomAction1<String>((set, value) {
  set(detailProductPrecoMedioUnitarioAtom, value);
});

final updateProductAverageSellPriceAction = atomAction1<String>((set, value) {
  set(detailProductPrecoMedioVendaAtom, value);
});
