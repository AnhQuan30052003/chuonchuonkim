import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../connect/setupFirebase.dart';

class Cart {
  String idCart, idUser, maSP;
  int soLuong;

  Cart({
    required this.idCart,
    required this.idUser,
    required this.maSP,
    required this.soLuong,
  });

  Map<String, dynamic> toJson() {
    return {
      'idCart': idCart,
      'idUser': idUser,
      'maSP': maSP,
      'soLuong': soLuong,
    };
  }

  factory Cart.fromJson(Map<String, dynamic> map) {
    return Cart(
      idCart: map['idCart'] as String,
      idUser: map['idUser'] as String,
      maSP: map['maSP'] as String,
      soLuong: map['soLuong'] as int,
    );
  }
}

class CartSnapshot {
  Cart cart;
  DocumentReference docRef;

  CartSnapshot({required this.cart, required this.docRef});

  factory CartSnapshot.fromDocSnap(DocumentSnapshot docSnap) {
    return CartSnapshot(
        cart: Cart.fromJson(docSnap.data() as Map<String, dynamic>),
        docRef: docSnap.reference
    );
  }

  static Future<DocumentReference> add(Cart object) async {
    return await FirebaseFirestore.instance.collection(Firebase.colCart).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(Cart object) async {
    await docRef.update(object.toJson());
  }

  static Stream<List<CartSnapshot>> streamData() {
    var c = ChuonChuonKimController.instance.userSnapshot;
    String id = (c == null ? "" : c.user.id);
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colCart).where("idUser", isEqualTo: id).snapshots();
    var list = querySnapshot.map(
      (qsn) => qsn.docs.map(
        (docSnap) => CartSnapshot.fromDocSnap(docSnap)
      ).toList()
    );

    return list;
  }

  static Future<List<CartSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colCart).where("idUser", isEqualTo: ChuonChuonKimController.instance.userSnapshot!.user.id).get();

    var list = qs.docs.map(
      (docSnap) => CartSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<Cart> dbCart = [
  Cart(idCart: "0001", idUser: "0001", maSP: "0001", soLuong: 1),
  Cart(idCart: "0002", idUser: "0001", maSP: "0002", soLuong: 1),
  Cart(idCart: "0003", idUser: "0001", maSP: "0003", soLuong: 5),
];