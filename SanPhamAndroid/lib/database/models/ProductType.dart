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

  static Stream<List<ProductTypeSnapshot>> streamData() {
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
  ProductType(maLSP: "001", tenLSP: "Cơm sườn", hinhAnhLSP: "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProductTypes%2Fcooking.png?alt=media&token=46aeee3c-0af4-4454-b9a1-350b6a1f4a3c"),
  ProductType(maLSP: "002", tenLSP: "Hamburger", hinhAnhLSP: "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProductTypes%2Fhamburger.png?alt=media&token=7ecf34aa-5a02-4e6b-9ebd-ec4dc5037011"),
  ProductType(maLSP: "003", tenLSP: "Bún", hinhAnhLSP: "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProductTypes%2Fnoodles.png?alt=media&token=95873746-1098-4b6f-8558-b3fb720ff9cf"),
  ProductType(maLSP: "004", tenLSP: "Phở", hinhAnhLSP: "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProductTypes%2Fpho.png?alt=media&token=8779915d-b714-4a7b-a43b-d511da9b9b49"),
  ProductType(maLSP: "005", tenLSP: "Nước", hinhAnhLSP: "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProductTypes%2Fsoda.png?alt=media&token=bbc11cdb-bab4-4563-aba8-5b2958ea8812"),
  ProductType(maLSP: "006", tenLSP: "Sald", hinhAnhLSP: "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProductTypes%2Fcai.png?alt=media&token=72b8372a-c2b2-481a-8c18-209925a4d03c")
];