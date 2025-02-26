import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/category_services.dart';
import '../services/unidades_de_medidas_services.dart';

class UnidadesDeMedidasRepository {
  final UnidadesDeMedidasService _unidadesDeMedidaService; // Use service

  UnidadesDeMedidasRepository(this._unidadesDeMedidaService);

  Stream<QuerySnapshot<Map<String, dynamic>>> getUnidadesDeMedidaStream() {
    return _unidadesDeMedidaService.getUnidadesDeMedidaStream();
  }
}
