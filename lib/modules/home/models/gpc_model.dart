class GpcBrickModel {
  final int brickCode;
  final String brickDescription;
  final String brickDefinition;
  final int classCode;
  final String classDescription;
  final int familyCode;
  final String familyDescription;
  final int segmentCode;
  final String segmentDescription;
  final String documentId;

  GpcBrickModel({
    required this.brickCode,
    required this.brickDescription,
    required this.brickDefinition,
    required this.classCode,
    required this.classDescription,
    required this.familyCode,
    required this.familyDescription,
    required this.segmentCode,
    required this.segmentDescription,
    required this.documentId,
  });

  // Factory method to create a GpcBrickModel object from a Firestore document
  factory GpcBrickModel.fromDoc(dynamic doc) {
    return GpcBrickModel(
      brickCode: doc.data()!['brickCode'],
      brickDescription: doc.data()!['brickDescription'] ?? '',
      brickDefinition: doc.data()!['brickDefinition'],
      classCode: doc.data()!['classCode'],
      classDescription: doc.data()!['classDescription'],
      familyCode: doc.data()!['familyCode'],
      familyDescription: doc.data()!['familyDescription'],
      segmentCode: doc.data()!['segmentCode'],
      segmentDescription: doc.data()!['segmentDescription'],
      documentId: doc.id,
    );
  }
}

class GpcClassModel {
  final int classCode;
  final String classDescription;
  final int familyCode;
  final String familyDescription;
  final int segmentCode;
  final String segmentDescription;
  final String documentId;

  GpcClassModel({
    required this.classCode,
    required this.classDescription,
    required this.familyCode,
    required this.familyDescription,
    required this.segmentCode,
    required this.segmentDescription,
    required this.documentId,
  });

  // Factory method to create a GpcClassModel object from a Firestore document
  factory GpcClassModel.fromDoc(dynamic doc) {
    return GpcClassModel(
      classCode: doc.data()!['classCode'],
      classDescription: doc.data()!['classDescription'],
      familyCode: doc.data()!['familyCode'],
      familyDescription: doc.data()!['familyDescription'],
      segmentCode: doc.data()!['segmentCode'],
      segmentDescription: doc.data()!['segmentDescription'],
      documentId: doc.id,
    );
  }
}

class GpcFamilyModel {
  final int familyCode;
  final String familyDescription;
  final int segmentCode;
  final String segmentDescription;
  final String documentId;

  GpcFamilyModel({
    required this.familyCode,
    required this.familyDescription,
    required this.segmentCode,
    required this.segmentDescription,
    required this.documentId,
  });

  // Factory method to create a GpcFamilyModel object from a Firestore document
  factory GpcFamilyModel.fromDoc(dynamic doc) {
    return GpcFamilyModel(
      familyCode: doc.data()!['familyCode'],
      familyDescription: doc.data()!['familyDescription'],
      segmentCode: doc.data()!['segmentCode'],
      segmentDescription: doc.data()!['segmentDescription'],
      documentId: doc.id,
    );
  }
}
