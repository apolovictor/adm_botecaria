import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<bool> addProduct(
    Map<String, dynamic> product,
    Uint8List? productImage,
  ) async {
    // return await _firestore.runTransaction((transaction) async {
    try {
      // 1. Verificar se cProd já existe
      final cProdQuery =
          await _firestore
              .collection('adm_products')
              .where('cProd', isEqualTo: product['cProd'])
              .get();

      if (cProdQuery.docs.isNotEmpty) {
        throw 'Já existe um produto com este nome no campo (cProd).';
      } else {
        // 2. Verificar se cEAN já existe (se fornecido)
        if (product['cEAN'] != null) {
          final cEANQuery =
              await _firestore
                  .collection('adm_products')
                  .where('cEAN', isEqualTo: product['cEAN'])
                  .get();

          if (cEANQuery.docs.isNotEmpty) {
            throw 'Já existe um produto com este código de barras (cEAN).';
          }
        }

        // // 3. Se não existir, criar o novo produto
        final productRef = _firestore.collection('adm_products').doc();

        product.addAll({
          'documentId': productRef.id,
          'createdAt': FieldValue.serverTimestamp(),
        });

        await productRef.set(product);

        // Upload da imagem (se houver)
        String? imageUrl;
        if (productImage != null) {
          imageUrl = await _uploadImage(productRef.id, productImage);
          productRef.update({'imageUrl': imageUrl});
        }
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Função auxiliar para upload da imagem
  Future<String> _uploadImage(String productId, Uint8List productImage) async {
    try {
      final storageRef = _storage.ref().child('adm_products/$productId');
      final uploadTask = await storageRef.putData(
        productImage,
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      debugPrint("Erro ao fazer upload da imagem: $e");
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAdmProducts() {
    return _firestore
        .collection("adm_products")
        .where('completionPercentage', isLessThan: 1)
        .snapshots();
  }
}
