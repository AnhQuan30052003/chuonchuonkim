import 'package:cloud_firestore/cloud_firestore.dart';
import '../connect/setupFirebase.dart';

class ProductFavorite {
  String idUser, maSP;

  ProductFavorite({
    required this.idUser,
    required this.maSP,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'maSP': maSP,
    };
  }

  factory ProductFavorite.fromJson(Map<String, dynamic> map) {
    return ProductFavorite(
      idUser: map['idUser'] as String,
      maSP: map['maSP'] as String,
    );
  }
}

class ProductFavoriteSnapshot {
  ProductFavorite productFavorite;
  DocumentReference docRef;

  ProductFavoriteSnapshot({required this.productFavorite, required this.docRef});

  factory ProductFavoriteSnapshot.fromDocSnap(DocumentSnapshot docSnap) {
    return ProductFavoriteSnapshot(
      productFavorite: ProductFavorite.fromJson(docSnap.data() as Map<String, dynamic>),
      docRef: docSnap.reference
    );
  }

  static Future<DocumentReference> add(ProductFavorite object) async {
    return FirebaseFirestore.instance.collection(Firebase.colProductFavorites).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(ProductFavorite object) async {
    await docRef.update(object.toJson());
  }

  static Future<List<ProductFavoriteSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colProductFavorites).get();

    var list = qs.docs.map(
      (docSnap) => ProductFavoriteSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<ProductFavorite> dbProductFavorite = [
  ProductFavorite(idUser: "0000001", maSP: "001"),
];