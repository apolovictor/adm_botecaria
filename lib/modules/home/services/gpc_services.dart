import 'package:cloud_firestore/cloud_firestore.dart';

class GpcService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getGpcFamilyStream() {
    return _firestore
        .collection("adm_gpc")
        .doc('gDnPdNSdADJADNttCiig')
        .collection('gpc_family')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGpcClassStream(
    String documentIdFamily,
  ) {
    return _firestore
        .collection("adm_gpc")
        .doc('gDnPdNSdADJADNttCiig')
        .collection('gpc_family')
        .doc(documentIdFamily)
        .collection('gpc_class')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGpcBrickStream(
    String documentIdFamily,
    String documentIdClass,
  ) {
    return _firestore
        .collection("adm_gpc")
        .doc('gDnPdNSdADJADNttCiig')
        .collection('gpc_family')
        .doc(documentIdFamily)
        .collection('gpc_class')
        .doc(documentIdClass)
        .collection('gpc_bricks')
        .snapshots();
  }
}
