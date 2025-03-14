import 'dart:typed_data';
import 'package:adm_botecaria/modules/home/models/gpc_model.dart';
import 'package:adm_botecaria/modules/home/models/products_model.dart';
import 'package:asp/asp.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
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
  set(productCategoryAtom, value);
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
    productPrecoMedioUnitarioAtom.state != null
        ? productPrecoMedioUnitarioAtom.state!.replaceAll(',', '.')
        : '',
  );
  double? productPrecoMedioVenda = double.tryParse(
    productPrecoMedioVendaAtom.state != null
        ? productPrecoMedioVendaAtom.state!.replaceAll(',', '.')
        : '',
  );

  final product = Product(
    cProd: productCodeAtom.state.toUpperCase().trim(),
    cEAN: productEanAtom.state,
    xProd: productNameAtom.state?.toUpperCase().trim(),
    NCM: productNCMAtom.state,
    gpcFamilyCode: gpcFamilySelectedAtom.state?.familyCode,
    gpcFamilyDescription: gpcFamilySelectedAtom.state?.familyDescription.trim(),
    gpcClassCode: gpcClassSelectedAtom.state?.classCode,
    gpcClassDescription: gpcClassSelectedAtom.state?.classDescription.trim(),
    gpcBrickCode: gpcBrickSelectedAtom.state?.brickCode,
    gpcBrickDescription: gpcBrickSelectedAtom.state?.brickDescription.trim(),
    gpcBrickDefinition: gpcBrickSelectedAtom.state?.brickDefinition.trim(),
    category: productCategoryAtom.state.documentId,
    categoryName: productCategoryAtom.state.iconName,
    uCom: productUComAtom.state?.trim(),
    imageUrl: null,
    manufacturerBrand: selectedManufacturersAtom.state?.name.trim(),
    CNPJFab: selectedManufacturersAtom.state?.cnpj,
    manufacturerImageUrl: selectedManufacturersAtom.state?.imageUrl,
    CEST: productCESTAtom.state,
    precoMedioUnitario: productPrecoMedioUnitario,
    precoMedioVenda: productPrecoMedioVenda,
    description: productDescriptionAtom.state?.trim(),
    status: 1,
  );

  try {
    await productRepository.addProduct(product, selectedImageState.state);
    clearImagenInlineImageList();
    clearProductImageAction();
    setProductCodeAction('');
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

final updateXProdAction = atomAction1<String?>((set, value) {
  set(detailProductXProdAtom, value);
});
final updateEanAction = atomAction1<int?>((set, value) {
  set(detailProductEanAtom, value);
});
final updateNCMAction = atomAction1<int?>((set, value) {
  set(detailProductNCMAtom, value);
});
final updateCESTAction = atomAction1<int?>((set, value) {
  set(detailProductCESTAtom, value);
});
final updateGPCFamilyAction = atomAction1<GpcFamilyModel?>((set, value) {
  set(detailProductgpcFamilySelectedAtom, value);
});
final updateGPCClassAction = atomAction1<GpcClassModel?>((set, value) {
  set(detailProductgpcClassSelectedAtom, value);
});
final updateGPCBrickAction = atomAction1<GpcBrickModel?>((set, value) {
  set(detailProductgpcBrickSelectedAtom, value);
});

final updateProductCategoriaAction = atomAction1<Categories>((set, value) {
  set(detailProductCategoryAtom, value);
});

final updateProductUComAction = atomAction1<String?>((set, value) {
  set(detailProductUComAtom, value);
});
final updateProductAverageUnitPriceAction = atomAction1<String?>((set, value) {
  set(detailProductPrecoMedioUnitarioAtom, value);
});

final updateProductAverageSellPriceAction = atomAction1<String?>((set, value) {
  set(detailProductPrecoMedioVendaAtom, value);
});

final addGpcFamilyToListUpdateAction = atomAction1<List<GpcFamilyModel>>((
  set,
  gpcFamily,
) {
  set(gpcFamilyUpdateListAtom, [...gpcFamily]);
});

final addGpcClassToListUpdateAction = atomAction1<List<GpcClassModel>>((
  set,
  gpcClass,
) {
  set(gpcClassListUpdateAtom, [...gpcClass]);
});

final addGpcBrickToListUpdateAction = atomAction1<List<GpcBrickModel>>((
  set,
  gpcBrick,
) {
  set(gpcBrickListUpdateAtom, [...gpcBrick]);
});

final updateSelectedManufacturerAction = atomAction1<Manufacturer?>((
  set,
  selected,
) {
  set(selectedManufacturersUpdateAtom, selected);
});

final filterManufacturerUpdateAction = atomAction1<dynamic>((set, filter) {
  set(filterManufacturersUpdateAtom, filter);
});

final clearSelectedManufacturerAndFilterUpdateAction = atomAction((set) {
  set(selectedManufacturersUpdateAtom, null);
  set(filterManufacturersUpdateAtom, null);
});

final updateProductDesciptionAction = atomAction1<String?>((set, value) {
  set(detailProductDescriptionAtom, value);
});

final updateProductAction = atomAction1<Product>((set, currentProduct) async {
  set(detailProductStateAtom, const DetailProductStates.loading());

  final ProductRepository productRepository = ProductRepository(
    getIt<ProductServices>(),
  );

  if (detailProductgpcFamilySelectedAtom.state?.familyCode != null &&
      detailProductgpcClassSelectedAtom.state?.classCode == null &&
      detailProductgpcBrickSelectedAtom.state?.brickCode == null) {
    set(
      detailProductStateAtom,
      DetailProductStatesError(
        'GPC preenchido. Família, Class e Bloco são obrigatórios',
      ),
    );

    return;
  }

  final updatedProduct = currentProduct.copyWith(
    // Use a conditional expression to only update if the existing field is null
    cProd: currentProduct.cProd, //Always updated
    xProd:
        currentProduct.xProd ??
        detailProductXProdAtom.state?.toUpperCase().trim(),
    cEAN: currentProduct.cEAN ?? detailProductEanAtom.state,
    NCM: currentProduct.NCM ?? detailProductNCMAtom.state,
    CEST: currentProduct.CEST ?? detailProductCESTAtom.state,
    gpcFamilyCode:
        currentProduct.gpcFamilyCode ??
        detailProductgpcFamilySelectedAtom.state?.familyCode,
    gpcFamilyDescription:
        currentProduct.gpcFamilyDescription ??
        detailProductgpcFamilySelectedAtom.state?.familyDescription.trim(),
    gpcClassCode:
        currentProduct.gpcClassCode ??
        detailProductgpcClassSelectedAtom.state?.classCode,
    gpcClassDescription:
        currentProduct.gpcClassDescription ??
        detailProductgpcClassSelectedAtom.state?.classDescription.trim(),
    gpcBrickCode:
        currentProduct.gpcBrickCode ??
        detailProductgpcBrickSelectedAtom.state?.brickCode,
    gpcBrickDescription:
        currentProduct.gpcBrickDescription ??
        detailProductgpcBrickSelectedAtom.state?.brickDescription.trim(),
    gpcBrickDefinition:
        currentProduct.gpcBrickDefinition ??
        detailProductgpcBrickSelectedAtom.state?.brickDefinition.trim(),
    category:
        currentProduct.category ?? detailProductCategoryAtom.state.documentId,
    categoryName:
        currentProduct.categoryName ?? detailProductCategoryAtom.state.iconName,
    uCom: currentProduct.uCom ?? detailProductUComAtom.state?.trim(),
    manufacturerBrand:
        currentProduct.manufacturerBrand ??
        selectedManufacturersUpdateAtom.state?.name.trim(),
    CNPJFab:
        currentProduct.CNPJFab ?? selectedManufacturersUpdateAtom.state?.cnpj,
    manufacturerImageUrl:
        currentProduct.manufacturerImageUrl ??
        selectedManufacturersUpdateAtom.state?.imageUrl,

    precoMedioUnitario:
        currentProduct.precoMedioUnitario ??
        double.tryParse(
          detailProductPrecoMedioUnitarioAtom.state != null
              ? detailProductPrecoMedioUnitarioAtom.state!.replaceAll(',', '.')
              : '',
        ),
    precoMedioVenda:
        currentProduct.precoMedioVenda ??
        double.tryParse(
          detailProductPrecoMedioVendaAtom.state != null
              ? detailProductPrecoMedioVendaAtom.state!.replaceAll(',', '.')
              : '',
        ),
    description:
        currentProduct.description ??
        detailProductDescriptionAtom.state?.trim(),
  );

  try {
    await productRepository.updateProduct(updatedProduct);

    final updatedProductMap = updatedProduct.toMap();

    await setSelectedCardAction(
      (updatedProductMap['completionPercentage']! * 14) as int,
    );

    //clear all atom fields
    updateXProdAction(null);
    updateEanAction(null);
    updateNCMAction(null);
    updateCESTAction(null);
    updateGPCFamilyAction(null);
    updateGPCClassAction(null);
    updateGPCBrickAction(null);
    updateProductCategoriaAction(Categories.empty());
    updateProductUComAction(null);
    updateProductAverageUnitPriceAction(null);
    updateProductAverageSellPriceAction(null);
    clearSelectedManufacturerAndFilterUpdateAction();
    updateProductDesciptionAction(null);

    set(
      detailProductStateAtom,
      const DetailProductStatesSuccess('Produto atualizado com sucesso!'),
    );
    return;
  } catch (e) {
    set(detailProductStateAtom, DetailProductStatesError(e.toString()));
  }
});

final addToimagenInlineImageList = atomAction1<List<ImagenInlineImage>>((
  set,
  images,
) {
  set(imagenInlineImageListAtom, [...images]);
});

final clearImagenInlineImageList = atomAction((set) {
  imagenInlineImageListAtom.state.clear();
  set(imagenInlineImageListAtom, imagenInlineImageListAtom.state);
});
