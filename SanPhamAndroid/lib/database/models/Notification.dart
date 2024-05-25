import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../connect/setupFirebase.dart';

class Notification {
  String idUser, maSP, text;
  bool seen;

  Notification({
    required this.idUser,
    required this.maSP,
    required this.text,
    required this.seen,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'maSP': maSP,
      'String': text,
      'seen': seen,
    };
  }

  factory Notification.fromJson(Map<String, dynamic> map) {
    return Notification(
      idUser: map['idUser'] as String,
      maSP: map['maSP'] as String,
      text: map['String'] as String,
      seen: map['seen'] as bool,
    );
  }
}

class NotificationSnapshot {
  Notification notification;
  DocumentReference docRef;

  NotificationSnapshot({required this.notification, required this.docRef});

  factory NotificationSnapshot.fromDocSnap(DocumentSnapshot docSnap) {
    return NotificationSnapshot(
      notification: Notification.fromJson(docSnap.data() as Map<String, dynamic>),
      docRef: docSnap.reference
    );
  }

  static Future<DocumentReference> add(Notification object) async {
    return FirebaseFirestore.instance.collection(Firebase.colNotification).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(Notification object) async {
    await docRef.update(object.toJson());
  }

  static Stream<List<NotificationSnapshot>> streamData() {
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colNotification).where("idUser", isEqualTo: ChuonChuonKimController.instance.idUser).snapshots();
    var list = querySnapshot.map(
      (qsn) => qsn.docs.map(
        (docSnap) => NotificationSnapshot.fromDocSnap(docSnap)
      ).toList()
    );

    return list;
  }

  static Future<List<NotificationSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colNotification).where("idUser", isEqualTo: ChuonChuonKimController.instance.idUser).get();

    var list = qs.docs.map(
            (docSnap) => NotificationSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<Notification> dbNotification = [
  Notification(idUser: "001", maSP: "001", text: "Đã xác nhận đơn hàng", seen: false),
  Notification(idUser: "001", maSP: "002", text: "Đã xác nhận đơn hàng", seen: false),
  Notification(idUser: "001", maSP: "003", text: "Đã xác nhận đơn hàng", seen: false),
  Notification(idUser: "001", maSP: "002", text: "Đã giao", seen: true),
];