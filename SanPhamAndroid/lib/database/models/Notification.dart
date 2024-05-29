import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../connect/setupFirebase.dart';

class Notification {
  String idNoti, idUser, maSP, text, toUser;
  bool seen;

  Notification({
    required this.idNoti,
    required this.idUser,
    required this.maSP,
    required this.text,
    required this.seen,
    required this.toUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'idNoti': idNoti,
      'idUser': idUser,
      'maSP': maSP,
      'String': text,
      'seen': seen,
      'toUser': toUser,
    };
  }

  factory Notification.fromJson(Map<String, dynamic> map) {
    return Notification(
      idNoti: map['idNoti'] as String,
      idUser: map['idUser'] as String,
      maSP: map['maSP'] as String,
      text: map['String'] as String,
      seen: map['seen'] as bool,
      toUser: map['toUser'] as String,
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
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colNotification).where("toUser", isEqualTo: ChuonChuonKimController.instance.idUser).snapshots();
    var list = querySnapshot.map(
      (qsn) => qsn.docs.map(
        (docSnap) => NotificationSnapshot.fromDocSnap(docSnap)
      ).toList()
    );

    return list;
  }

  static Future<List<NotificationSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colNotification).where("toUser", isEqualTo: ChuonChuonKimController.instance.idUser).get();

    var list = qs.docs.map(
      (docSnap) => NotificationSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<Notification> dbNotification = [
  Notification(idNoti: "0001", idUser: "0000", maSP: "0001", text: "Admin đã xác nhận đơn hàng mã 0001", seen: true, toUser: "0001"),
  Notification(idNoti: "0002", idUser: "0000", maSP: "0002", text: "Admin đã xác nhận đơn hàng mã 0002", seen: true, toUser: "0001"),
  Notification(idNoti: "0003", idUser: "0000", maSP: "0003", text: "Admin đã xác nhận đơn hàng mã 0003", seen: true, toUser: "0001"),
  Notification(idNoti: "0004", idUser: "0000", maSP: "0004", text: "Admin đã xác nhận đơn hàng mã 0004", seen: false, toUser: "0001"),
  Notification(idNoti: "0005", idUser: "0000", maSP: "0005", text: "Admin đã xác nhận đơn hàng mã 0005", seen: false, toUser: "0001"),
];