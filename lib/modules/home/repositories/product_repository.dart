import 'dart:typed_data';

import '../models/products_model.dart';
import '../services/product_services.dart';

class ProductRepository {
  final ProductServices productService;

  ProductRepository(this.productService);

  Future<dynamic> addProduct(Product product, Uint8List? productImage) async {
    try {
      final response = await productService.addProduct(
        product.toMap(),
        productImage,
      );
      print(response);
      return response;
    } catch (e) {
      print('object   ${e}');
      rethrow;
    }
  }
}
