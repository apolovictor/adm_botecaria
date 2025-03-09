import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../modules/home/models/products_model.dart';

class ImageService {
  final _cacheManager = DefaultCacheManager();

  Future<Widget> loadImage(Product product, {required BoxFit fit}) async {
    try {
      return product.imageUrl != null && product.imageUrl!.isNotEmpty
          ? Image.network(product.imageUrl!)
          : Icon(Icons.image_not_supported, color: Colors.grey.shade700);
    } catch (e) {
      debugPrint("Error loading image: $e");
      return const Icon(Icons.error); // Placeholder for errors
    }
  }

  // Future<Widget> loadImageToProductReport(ProductReport product,
  //     {required BoxFit fit}) async {
  //   try {
  //     return Image.network(product.imageUrl!);
  //   } catch (e) {
  //     debugPrint("Error loading image: $e");
  //     return const Icon(Icons.error); // Placeholder for errors
  //   }
  // }

  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }

  Future<FileInfo?> getFileFromCache(String url) async {
    // Add getFileFromCache method to simplify logic
    return _cacheManager.getFileFromCache(url);
  }
}

final imageServiceProvider = Provider<ImageService>((ref) => ImageService());
