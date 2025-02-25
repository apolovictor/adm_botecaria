import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoriesStream() {
    return _firestore
        .collection("categories")
        .where('status', isEqualTo: 1)
        .orderBy('idIcon')
        .snapshots();
  }
}
