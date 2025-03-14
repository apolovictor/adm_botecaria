import 'dart:typed_data';

import 'package:adm_botecaria/modules/home/models/gpc_model.dart';
import 'package:adm_botecaria/modules/home/models/products_model.dart';
import 'package:adm_botecaria/modules/home/providers/states/gen_ai_states.dart';
import 'package:asp/asp.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/widgets.dart';

import '../models/category_model.dart';
import '../models/manufacturers_model.dart';
import '../models/unidades_de_medida_model.dart';
import '../providers/states/detail_product_states.dart';
import '../providers/states/product_states.dart';

// Átomos para os campos do formulário de produto
final selectedImageState = atom<Uint8List?>(null);
final productCodeAtom = atom<String>('');
final productEanAtom = atom<int?>(null);
final productNameAtom = atom<String?>(null);
final productNCMAtom = atom<int?>(null);

final productCategoryAtom = atom<Categories>(Categories.empty());
final productUComAtom = atom<String?>(null);
final productManufacturerBrandAtom = atom<String?>(null);
final productCNPJFabAtom = atom<String?>(null);
final productCESTAtom = atom<int?>(null);
final productPrecoMedioUnitarioAtom = atom<String?>(null);
final productPrecoMedioVendaAtom = atom<String?>(null);
final productDescriptionAtom = atom<String?>(null);
final gpcFamilySelectedAtom = atom<GpcFamilyModel?>(null);
final gpcClassSelectedAtom = atom<GpcClassModel?>(null);
final gpcBrickSelectedAtom = atom<GpcBrickModel?>(null);

final scrollControllerAtom = atom<ScrollController>(ScrollController());
final isPositionFloatingButtonAtom = atom<bool>(false);
final categoriesListAtom = atom<List<Categories>>([]);
final unidadesDeMeddidaListAtom = atom<List<UnidadesDeMedidaModel>>([]);
final filteredManufacturersListAtom = atom<List<Manufacturer>>([]);
final filterManufacturersAtom = atom<dynamic>(null);
final selectedManufacturersAtom = atom<Manufacturer?>(null);

final gpcFamilyListAtom = atom<List<GpcFamilyModel>>([]);
final gpcClassListAtom = atom<List<GpcClassModel>>([]);
final gpcBrickListAtom = atom<List<GpcBrickModel>>([]);

final productStateAtom = atom<ProductStatusState>(ProductStatusStateInitial());

final productListAtom = atom<List<Product>>([]);

final selectedCardAtom = atom<int>(13);

final selectedProductAtom = atom<Product?>(null);

final detailProductStateAtom = atom<DetailProductStates>(
  DetailProductStatesInitial(),
);

//Detail Products
final selectedImageOfDetailProductState = atom<Uint8List?>(null);

final detailProductCodeAtom = atom<String>('');
final detailProductXProdAtom = atom<String?>(null);
final detailProductEanAtom = atom<int?>(null);
final detailProductNCMAtom = atom<int?>(null);
final detailProductCESTAtom = atom<int?>(null);

final detailProductCategoryAtom = atom<Categories>(Categories.empty());
final detailProductUComAtom = atom<String?>(null);
final selectedManufacturersUpdateAtom = atom<Manufacturer?>(null);
final filterManufacturersUpdateAtom = atom<dynamic>(null);

// final detailProductManufacturerBrandAtom = atom<String>('');
// final detailProductCNPJFabAtom = atom<String>('');
final detailProductPrecoMedioUnitarioAtom = atom<String?>(null);
final detailProductPrecoMedioVendaAtom = atom<String?>(null);
final detailProductDescriptionAtom = atom<String?>(null);
final detailProductgpcFamilySelectedAtom = atom<GpcFamilyModel?>(null);
final detailProductgpcClassSelectedAtom = atom<GpcClassModel?>(null);
final detailProductgpcBrickSelectedAtom = atom<GpcBrickModel?>(null);

final gpcFamilyUpdateListAtom = atom<List<GpcFamilyModel>>([]);

final gpcClassListUpdateAtom = atom<List<GpcClassModel>>([]);

final gpcBrickListUpdateAtom = atom<List<GpcBrickModel>>([]);

final scrollControllerCardGoalsAtom = atom<ScrollController>(
  ScrollController(),
);

final imagenInlineImageListAtom = atom<List<ImagenInlineImage>>([]);

final isPressedAtom = atom<bool>(false);

final genAiStateAtom = atom<GenAiStates>(GenAiStatesInitial());

final promptAtom = atom<String>('');
