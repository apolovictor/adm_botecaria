import 'dart:typed_data';

import 'package:asp/asp.dart';

// Átomos para os campos do formulário de produto
final productCodeAtom = atom<String>('');
final productEANAtom = atom<String>('');
final productNameAtom = atom<String>('');
final productNCMAtom = atom<String>('');
final productEXTIPIAtom = atom<String>('');
final productCFOPAtom = atom<String>('');
final productUComAtom = atom<String>('');
final productQComAtom = atom<double>(0.0);
final productVUnComAtom = atom<double>(0.0);
final productVProdAtom = atom<double>(0.0);

final productImageUrlAtom = atom<String>('');
final productCategoriaAtom = atom<String>('');
final productGpcCodeAtom = atom<String>('');
final productMarcaAtom = atom<String>('');
final productDescricaoAtom = atom<String>('');
final productCESTAtom = atom<String>('');
final productIndEscalaAtom = atom<String>('');
final productCNPJFabAtom = atom<String>('');
final productCBenefAtom = atom<String>('');

final productQVolAtom = atom<double>(0.0);
final productUTribAtom = atom<String>('');
final productQTribAtom = atom<double>(0.0);
final productVUnTribAtom = atom<double>(0.0);
final productNLoteAtom = atom<String>('');
final productQLoteAtom = atom<double>(0.0);
final productDFabAtom = atom<String>('');
final productDValAtom = atom<String>('');

final selectedImageState = atom<Uint8List?>(null);
