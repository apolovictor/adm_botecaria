import 'package:adm_botecaria/modules/home/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/provider/images_provider.dart';

class ProductCardImage extends ConsumerWidget {
  const ProductCardImage({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageWidget = ref.watch(imageWidgetProvider(product));

    return imageWidget.when(
      data: (widget) => widget,
      error: (error, stackTrace) => const Icon(Icons.error),
      loading:
          () => const SizedBox(
            height: 95,
            width: 95,
            child: Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
