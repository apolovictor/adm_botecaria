import 'dart:typed_data';

import 'package:asp/asp.dart';
import 'package:flutter/widgets.dart';

// Átomos para os campos do formulário de produto
final selectedImageState = atom<Uint8List?>(null);
final productCodeAtom = atom<String>('');
final productEanAtom = atom<String>('');
final productNameAtom = atom<String>('');
final productNCMAtom = atom<String>('');
final productGpcCodeAtom = atom<String>('');
final productCategoriaAtom = atom<String>('');
final productUComAtom = atom<String>('');
final productMarcaAtom = atom<String>('');
final productCNPJFabAtom = atom<String>('');
final productCESTAtom = atom<String>('');
final productPrecoMedioUnitarioAtom = atom<double>(0.0);
final productPrecoMedioVendaAtom = atom<String>('');
final productDescricaoAtom = atom<String>('');

final scrollControllerAtom = atom<ScrollController>(ScrollController());
final isPositionFloatingButtonAtom = atom<bool>(false);
