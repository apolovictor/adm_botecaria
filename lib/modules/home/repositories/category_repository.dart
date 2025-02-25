import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/category_services.dart';

class CategoryRepository {
  final CategoryService _categoryService; // Use service

  CategoryRepository(this._categoryService);

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoriesStream() {
    return _categoryService.getCategoriesStream();
  }
}
