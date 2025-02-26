import 'package:adm_botecaria/modules/home/models/gpc_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/gpc_services.dart';

class GpcRepository {
  final GpcService _gpcService;

  GpcRepository(this._gpcService);

  Stream<QuerySnapshot<Map<String, dynamic>>> getGpcFamilyStream() {
    return _gpcService.getGpcFamilyStream();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGpcClassStream(
    GpcFamilyModel gpcFamilySelected,
  ) {
    return _gpcService.getGpcClassStream(gpcFamilySelected.documentId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGpcBrickStream(
    GpcFamilyModel gpcFamilySelected,
    GpcClassModel gpcClassSelected,
  ) {
    return _gpcService.getGpcBrickStream(
      gpcFamilySelected.documentId,
      gpcClassSelected.documentId,
    );
  }
}
