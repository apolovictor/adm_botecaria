import 'dart:typed_data';

import 'package:adm_botecaria/modules/home/models/gpc_model.dart';
import 'package:asp/asp.dart';
import 'package:flutter/widgets.dart';

import '../models/category_model.dart';
import '../models/manufacturers_model.dart';
import '../models/unidades_de_medida_model.dart';
import '../providers/states/product_states.dart';

// Átomos para os campos do formulário de produto
final selectedImageState = atom<Uint8List?>(null);
final productCodeAtom = atom<String>('');
final productEanAtom = atom<int?>(null);
final productNameAtom = atom<String>('');
final productNCMAtom = atom<int?>(null);

final productCategoryaAtom = atom<Categories>(Categories.empty());
final productUComAtom = atom<String>('');
final productManufacturerBrandAtom = atom<String>('');
final productCNPJFabAtom = atom<String>('');
final productCESTAtom = atom<int?>(null);
final productPrecoMedioUnitarioAtom = atom<String>('');
final productPrecoMedioVendaAtom = atom<String>('');
final productDescriptionAtom = atom<String>('');
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
