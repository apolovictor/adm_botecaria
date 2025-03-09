import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../shared/provider/images_provider.dart';
import '../../models/products_model.dart';

class DetailProductCardImage extends HookConsumerWidget {
  const DetailProductCardImage({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageWidget = ref.watch(imageWidgetProvider(product));

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(12),
        width: 400,
        height: 400,
        child: imageWidget.when(
          data: (widget) => widget,
          error: (error, stackTrace) => const Icon(Icons.error),
          loading:
              () => const SizedBox(
                height: 100,
                width: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
        ),
      ),
    );
  }
}
