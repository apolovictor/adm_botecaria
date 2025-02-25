import 'package:cloud_firestore/cloud_firestore.dart';

class UnidadesDeMedidasRService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUnidadesDeMedidaStream() {
    return _firestore
        .collection("adm_unidades_de_medida")
        .where('status', isEqualTo: 1)
        .snapshots();
  }
}
