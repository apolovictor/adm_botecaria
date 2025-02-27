class Manufacturer {
  final String name;
  final List<dynamic> cnpj;
  final int status;
  final String imageUrl;
  final String documentId;

  Manufacturer({
    required this.name,
    required this.cnpj,
    required this.status,
    required this.imageUrl,
    required this.documentId,
  });

  // Factory method to create a Manufacturer object from a Firestore document
  factory Manufacturer.fromDoc(dynamic doc) {
    return Manufacturer(
      name: doc.data()!['name'],
      cnpj: doc.data()!['cnpj'],
      imageUrl: doc.data()!['imageUrl'],
      status: doc.data()!['status'],
      documentId: doc.id,
    );
  }

  // Method to convert a Manufacturer object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {'name': name, 'cnpj': cnpj, 'imageUrl': imageUrl, 'status': status};
  }
}
