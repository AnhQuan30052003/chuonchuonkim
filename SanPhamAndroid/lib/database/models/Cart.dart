import 'package:cloud_firestore/cloud_firestore.dart';
import '../connect/setupFirebase.dart';

class Cart {
  String idUser, maSP;
  int soLuong;

  Cart({
    required this.idUser,
    required this.maSP,
    required this.soLuong,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'maSP': maSP,
      'soLuong': soLuong,
    };
  }

  factory Cart.fromJson(Map<String, dynamic> map) {
    return Cart(
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
    return FirebaseFirestore.instance.collection(Firebase.colCart).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(Cart object) async {
    await docRef.update(object.toJson());
  }

  static Future<List<CartSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colCart).get();

    var list = qs.docs.map(
      (docSnap) => CartSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<Cart> dbCart = [
  Cart(idUser: "0000001", maSP: "001", soLuong: 1),
];