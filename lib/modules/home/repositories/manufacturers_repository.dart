import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/manufacturers_services.dart';

class ManufacturersRepository {
  final ManufacturersServices _manufacturersService; // Use service

  ManufacturersRepository(this._manufacturersService);

  Stream<QuerySnapshot<Map<String, dynamic>>> getManufacturersStream() {
    return _manufacturersService.getManufacturersStream();
  }
}
