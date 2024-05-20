import 'package:cloud_firestore/cloud_firestore.dart';
import '../connect/setupFirebase.dart';

class ProductType {
  String maLSP, tenLSP, hinhAnhLSP;

  ProductType({
    required this.maLSP,
    required this.tenLSP,
    required this.hinhAnhLSP,
  });

  Map<String, dynamic> toJson() {
    return {
      'maLSP': maLSP,
      'tenLSP': tenLSP,
      'hinhAnhLSP': hinhAnhLSP,
    };
  }

  factory ProductType.fromJson(Map<String, dynamic> map) {
    return ProductType(
      maLSP: map['maLSP'] as String,
      tenLSP: map['tenLSP'] as String,
      hinhAnhLSP: map['hinhAnhLSP'] as String,
    );
  }
}

class ProductTypeSnapshot {
  ProductType productType;
  DocumentReference docRef;

  ProductTypeSnapshot({required this.productType, required this.docRef});

  factory ProductTypeSnapshot.fromDocSnap(DocumentSnapshot docSnap) {
    return ProductTypeSnapshot(
        productType: ProductType.fromJson(docSnap.data() as Map<String, dynamic>),
        docRef: docSnap.reference
    );
  }

  static Future<DocumentReference> add(ProductType object) async {
    return FirebaseFirestore.instance.collection(Firebase.colProductType).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(ProductType object) async {
    await docRef.update(object.toJson());
  }

  static Stream<List<ProductTypeSnapshot>> getData() {
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colProductType).snapshots();
    var list = querySnapshot.map(
      (qsn) => qsn.docs.map(
        (docSnap) => ProductTypeSnapshot.fromDocSnap(docSnap)
      ).toList()
    );

    return list;
  }

  static Future<List<ProductTypeSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colProductType).get();

    var list = qs.docs.map(
      (docSnap) => ProductTypeSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<ProductType> dbProductType = [
  ProductType(maLSP: "001", tenLSP: "Cơm", hinhAnhLSP: ""),
  ProductType(maLSP: "002", tenLSP: "Nước uống", hinhAnhLSP: "")
];