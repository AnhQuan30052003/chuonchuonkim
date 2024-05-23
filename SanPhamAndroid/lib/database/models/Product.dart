// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import '../connect/setupFirebase.dart';

class Product {
  String maSP, tenSP, moTaSP, hinhAnhSP, maLSP;
  int giaSP;

  Product({
    required this.maSP,
    required this.tenSP,
    required this.moTaSP,
    required this.hinhAnhSP,
    required this.giaSP,
    required this.maLSP,
  });

  Map<String, dynamic> toJson() {
    return {
      'maSP': maSP,
      'tenSP': tenSP,
      'moTaSP': moTaSP,
      'hinhAnhSP': hinhAnhSP,
      'maLSP': maLSP,
      'giaSP': giaSP,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      maSP: map['maSP'] as String,
      tenSP: map['tenSP'] as String,
      moTaSP: map['moTaSP'] as String,
      hinhAnhSP: map['hinhAnhSP'] as String,
      maLSP: map['maLSP'] as String,
      giaSP: map['giaSP'] as int,
    );
  }
}

class ProductSnapshot {
  Product product;
  DocumentReference docRef;

  ProductSnapshot({required this.product, required this.docRef});

  factory ProductSnapshot.fromDocSnap(DocumentSnapshot docSnap) {
    return ProductSnapshot(
        product: Product.fromJson(docSnap.data() as Map<String, dynamic>),
        docRef: docSnap.reference);
  }

  static Future<DocumentReference> add(Product object) async {
    return FirebaseFirestore.instance.collection(Firebase.colProduct).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(Product object) async {
    await docRef.update(object.toJson());
  }

  static Stream<List<ProductSnapshot>> streamData() {
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colProduct).snapshots();
    var list = querySnapshot
        .map((qsn) => qsn.docs.map((docSnap) => ProductSnapshot.fromDocSnap(docSnap)).toList());

    return list;
  }

  static Future<List<ProductSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colProduct).get();

    var list = qs.docs.map((docSnap) => ProductSnapshot.fromDocSnap(docSnap)).toList();

    return list;
  }
}

List<Product> dbProduct = [];