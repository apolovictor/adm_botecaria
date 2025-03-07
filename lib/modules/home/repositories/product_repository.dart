import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

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
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAdmProducts() {
    return productService.getAdmProducts();
  }
}
