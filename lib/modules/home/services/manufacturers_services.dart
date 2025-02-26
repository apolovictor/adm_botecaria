import 'package:cloud_firestore/cloud_firestore.dart';

class ManufacturersServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getManufacturersStream() {
    return _firestore
        .collection("adm_manufacturers")
        .where('status', isEqualTo: 1)
        .snapshots();
  }
}
