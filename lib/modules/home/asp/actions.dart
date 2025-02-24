import 'dart:typed_data';

import 'package:asp/asp.dart';
import 'atoms.dart';

// Actions para modificar os átomos dos campos de produto
final setProductCodeAction = atomAction1<String>((set, value) {
  set(productCodeAtom, value);
});

final setProductEANAction = atomAction1<String>((set, value) {
  set(productEANAtom, value);
});

final setProductNameAction = atomAction1<String>((set, value) {
  set(productNameAtom, value);
});

final setProductNCMAction = atomAction1<String>((set, value) {
  set(productNCMAtom, value);
});

final setProductEXTIPIAction = atomAction1<String>((set, value) {
  set(productEXTIPIAtom, value);
});

final setProductCFOPAction = atomAction1<String>((set, value) {
  set(productCFOPAtom, value);
});

final setProductUComAction = atomAction1<String>((set, value) {
  set(productUComAtom, value);
});

final setProductQComAction = atomAction1<double>((set, value) {
  set(productQComAtom, value);
});

final setProductVUnComAction = atomAction1<double>((set, value) {
  set(productVUnComAtom, value);
});

final setProductVProdAction = atomAction1<double>((set, value) {
  set(productVProdAtom, value);
});

final setProductImageUrlAction = atomAction1<String>((set, value) {
  set(productImageUrlAtom, value);
});
final setProductCategoriaAction = atomAction1<String>((set, value) {
  set(productCategoriaAtom, value);
});
final setProductGpcCodeAction = atomAction1<String>((set, value) {
  set(productGpcCodeAtom, value);
});
final setProductMarcaAction = atomAction1<String>((set, value) {
  set(productMarcaAtom, value);
});
final setProductDescricaoAction = atomAction1<String>((set, value) {
  set(productDescricaoAtom, value);
});
final setProductCESTAction = atomAction1<String>((set, value) {
  set(productCESTAtom, value);
});
final setProductIndEscalaAction = atomAction1<String>((set, value) {
  set(productIndEscalaAtom, value);
});
final setProductCNPJFabAction = atomAction1<String>((set, value) {
  set(productCNPJFabAtom, value);
});
final setProductCBenefAction = atomAction1<String>((set, value) {
  set(productCBenefAtom, value);
});
final setProductQVolAction = atomAction1<double>((set, value) {
  set(productQVolAtom, value);
});
final setProductUTribAction = atomAction1<String>((set, value) {
  set(productUTribAtom, value);
});
final setProductQTribAction = atomAction1<double>((set, value) {
  set(productQTribAtom, value);
});
final setProductVUnTribAction = atomAction1<double>((set, value) {
  set(productVUnTribAtom, value);
});
final setProductNLoteAction = atomAction1<String>((set, value) {
  set(productNLoteAtom, value);
});
final setProductQLoteAction = atomAction1<double>((set, value) {
  set(productQLoteAtom, value);
});
final setProductDFabAction = atomAction1<String>((set, value) {
  set(productDFabAtom, value);
});
final setProductDValAction = atomAction1<String>((set, value) {
  set(productDValAtom, value);
});

final setProductImageAction = atomAction1<Uint8List>((set, image) {
  set(selectedImageState, image);
});

final clearProductImageAction = atomAction((set) {
  set(selectedImageState, null);
});
