import 'dart:typed_data';

import '../asp/actions.dart';
import '../models/products_model.dart';
import '../repositories/product_repository.dart';

class UpdateImageProductInteractor {
  final ProductRepository _productRepository;

  UpdateImageProductInteractor(this._productRepository);

  Future<String> execute(Product product, Uint8List productImage) async {
    try {
      final imageUrlResponse = await _productRepository
          .updateImageOfProductOnCloudStorage(product, productImage);
      if (imageUrlResponse.isNotEmpty) {
        try {
          product = product.copyWith(
            imageUrl: imageUrlResponse,
            documentId: product.documentId,
          );
          await _productRepository.updateImageOfProductOnFirestore(
            product,
            imageUrlResponse,
          );

          final updatedProductMap = product.toMap();

          setSelectedCardAction(
            (updatedProductMap['completionPercentage']! * 14) as int,
          );
          return imageUrlResponse;
        } catch (e) {
          rethrow;
        }
      }
      return imageUrlResponse;
    } catch (e) {
      rethrow;
    }
  }
}
