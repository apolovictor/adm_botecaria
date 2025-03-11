import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Categories extends Equatable {
  final String? documentId;
  final int idIcon;
  final String? iconName;
  final String svgPath;
  final String primaryColor;
  final String secondaryColor;
  final int status;

  const Categories({
    this.documentId,
    required this.idIcon,
    required this.iconName,
    required this.svgPath,
    required this.primaryColor,
    required this.secondaryColor,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'idIcon': idIcon,
      'iconName': iconName,
      'svgPath': svgPath,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'status': status,
    };
  }

  static Categories fromDoc(dynamic doc) {
    return Categories(
      idIcon: doc.data()!['idIcon'],
      iconName: doc.data()!['iconName'],
      svgPath: doc.data()!['svgPath'],
      primaryColor: doc.data()!['primaryColor'],
      secondaryColor: doc.data()!['secondaryColor'],
      status: doc.data()!['status'],
      documentId: doc.id,
    );
  }

  Categories copyWith({
    String? documentId,
    int? idIcon,
    String? iconName,
    String? svgPath,
    String? primaryColor,
    String? secondaryColor,
    int? status,
  }) {
    return Categories(
      documentId: documentId ?? this.documentId,
      idIcon: idIcon ?? this.idIcon,
      iconName: iconName ?? this.iconName,
      svgPath: svgPath ?? this.svgPath,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      status: status ?? this.status,
    );
  }

  static Categories empty() {
    return Categories(
      idIcon: 0,
      iconName: null,
      svgPath: '',
      primaryColor: '',
      secondaryColor: '',
      status: 0,
      documentId: null,
    );
  }

  @override
  List<Object?> get props => [
    documentId,
    iconName,
    idIcon,
    primaryColor,
    secondaryColor,
    status,
    svgPath,
  ]; // List properties used for equality
}
