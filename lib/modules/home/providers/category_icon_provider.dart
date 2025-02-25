import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/file_service.dart';
import '../models/category_model.dart';

final categoryIconProvider = FutureProvider.family<Widget, Categories>((
  ref,
  category,
) async {
  // Use family
  final svgService = ref.watch(svgServiceProvider);

  return svgService.loadCachedSvg(category.svgPath); // Correct use of service
});
