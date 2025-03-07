import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../modules/home/models/products_model.dart';
import '../helpers/file_service.dart';

final imageWidgetProvider = FutureProvider.family<Widget, Product>((
  ref,
  product,
) async {
  // Parameter should be imageUrl. Use family modifier

  final imageService = ref.watch(imageServiceProvider);
  final imageWidget = await imageService.loadImage(
    product,
    fit: BoxFit.scaleDown,
  ); // Correctly use await, and no need to pass BuildContext

  return imageWidget; // Return the widget directly
});
