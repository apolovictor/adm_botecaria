import 'dart:typed_data';

import 'package:adm_botecaria/modules/home/models/gpc_model.dart';
import 'package:asp/asp.dart';
import '../models/category_model.dart';
import '../models/manufacturers_model.dart';
import '../models/unidades_de_medida_model.dart';
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
final setProductEanAction = atomAction1<String>((set, value) {
  set(productEanAtom, value);
});
final setProductNameAction = atomAction1<String>((set, value) {
  set(productNameAtom, value);
});
final setProductNCMAction = atomAction1<String>((set, value) {
  set(productNCMAtom, value);
});
final setProductGpcCodeAction = atomAction1<String>((set, value) {
  set(productGpcCodeAtom, value);
});
final setProductCategoriaAction = atomAction1<String>((set, value) {
  set(productCategoriaAtom, value);
});
final setProductUComAction = atomAction1<String>((set, value) {
  set(productUComAtom, value);
});
final setProductMarcaAction = atomAction1<String>((set, value) {
  set(productMarcaAtom, value);
});
final setProductCNPJFabAction = atomAction1<String>((set, value) {
  set(productCNPJFabAtom, value);
});
final setProductCESTAction = atomAction1<String>((set, value) {
  set(productCESTAtom, value);
});
final setProductAverageSellPriceAction = atomAction1<double>((set, value) {
  set(productPrecoMedioVendaAtom, value);
});
final setProductAverageUnitPriceAction = atomAction1<double>((set, value) {
  set(productPrecoMedioUnitarioAtom, value);
});
final setProductDescricaoAction = atomAction1<String>((set, value) {
  set(productDescricaoAtom, value);
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
