import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UnidadesDeMedidaModel extends Equatable {
  final String? documentId;
  final String name;
  final int status;

  const UnidadesDeMedidaModel({
    required this.documentId,
    required this.name,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {'documentId': documentId, 'name': name, 'status': status};
  }

  static UnidadesDeMedidaModel fromDoc(dynamic doc) {
    return UnidadesDeMedidaModel(
      name: doc.data()!['name'],
      status: doc.data()!['status'],
      documentId: doc.id,
    );
  }

  @override
  List<Object?> get props => [documentId, name, status]; // List properties used for equality
}
