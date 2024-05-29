import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../connect/setupFirebase.dart';

class ProductFavorite {
  String idPF, idUser, maSP;

  ProductFavorite({
    required this.idPF,
    required this.idUser,
    required this.maSP,
  });

  Map<String, dynamic> toJson() {
    return {
      'idPF': idPF,
      'idUser': idUser,
      'maSP': maSP,
    };
  }

  factory ProductFavorite.fromJson(Map<String, dynamic> map) {
    return ProductFavorite(
      idPF: map['idPF'] as String,
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
    return await FirebaseFirestore.instance.collection(Firebase.colProductFavorite).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(ProductFavorite object) async {
    await docRef.update(object.toJson());
  }

  static Stream<List<ProductFavoriteSnapshot>> streamData() {
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colProductFavorite).where("idUser", isEqualTo: ChuonChuonKimController.instance.user!.id).snapshots();
    var list = querySnapshot.map(
      (qsn) => qsn.docs.map(
          (docSnap) => ProductFavoriteSnapshot.fromDocSnap(docSnap)
      ).toList()
    );

    return list;
  }

  static Future<List<ProductFavoriteSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colProductFavorite).where("idUser", isEqualTo: ChuonChuonKimController.instance.user!.id).get();

    var list = qs.docs.map(
      (docSnap) => ProductFavoriteSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<ProductFavorite> dbProductFavorite = [
  ProductFavorite(idPF: "0001", idUser: "0001", maSP: "0001"),
  ProductFavorite(idPF: "0002", idUser: "0001", maSP: "0002"),
  ProductFavorite(idPF: "0002", idUser: "0001", maSP: "0003"),
];