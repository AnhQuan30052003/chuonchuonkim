import 'package:cloud_firestore/cloud_firestore.dart';

import '../connect/setupFirebase.dart';

class User {
  String id, user, pass, ten, sdt;
  List<String> diaChi;

  User({
    required this.id,
    required this.user,
    required this.pass,
    required this.ten,
    required this.sdt,
    required this.diaChi,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'pass': pass,
      'ten': ten,
      'sdt': sdt,
      'diaChi': diaChi,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      user: map['user'] as String,
      pass: map['pass'] as String,
      ten: map['ten'] as String,
      sdt: map['sdt'] as String,
      diaChi: map['diaChi'] as List<String>,
    );
  }
}

class UserSnapshot {
  User user;
  DocumentReference docRef;

  UserSnapshot({required this.user, required this.docRef});

  factory UserSnapshot.fromDocSnap(DocumentSnapshot docSnap) {
    return UserSnapshot(
      user: User.fromJson(docSnap.data() as Map<String, dynamic>),
      docRef: docSnap.reference
    );
  }

  static Future<DocumentReference> add(User object) async {
    return FirebaseFirestore.instance.collection(Firebase.colUser).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(User object) async {
    await docRef.update(object.toJson());
  }

  static Stream<List<UserSnapshot>> streamData() {
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colUser).snapshots();
    var list = querySnapshot.map(
      (qsn) => qsn.docs.map(
        (docSnap) => UserSnapshot.fromDocSnap(docSnap)
      ).toList()
    );

    return list;
  }

  static Future<List<UserSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colUser).get();
    var list = qs.docs.map((docSnap) => UserSnapshot.fromDocSnap(docSnap)).toList();
    return list;
  }
}

List<User> dbUser = [
  User(id: "0000", user: "admin", pass: "adminn", ten: "Admin", diaChi: List.of([]), sdt: ""),
  User(id: "0001", user: "tiendat", pass: "tiendat", ten: "Nguyễn Tiến Đạt", diaChi: List.of(["Ninh Hiệp, Khánh Hoà"]), sdt: ""),
  User(id: "0002", user: "anhquan", pass: "anhquan", ten: "Nguyễn Anh Quân", diaChi: List.of(["Ninh Thân, Khánh Hoà"]), sdt: "0398090114"),
];