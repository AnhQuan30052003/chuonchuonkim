import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../connect/setupFirebase.dart';

class Notifications {
  String idNoti, idUser, maSP, text, toUser;
  int soLuong;
  bool seen;

  Notifications({
    required this.idNoti,
    required this.idUser,
    required this.maSP,
    required this.text,
    required this.seen,
    required this.toUser,
    required this.soLuong,
  });

  Map<String, dynamic> toJson() {
    return {
      'idNoti': idNoti,
      'idUser': idUser,
      'maSP': maSP,
      'String': text,
      'seen': seen,
      'toUser': toUser,
      'soLuong': soLuong,
    };
  }

  factory Notifications.fromJson(Map<String, dynamic> map) {
    return Notifications(
      idNoti: map['idNoti'] as String,
      idUser: map['idUser'] as String,
      maSP: map['maSP'] as String,
      text: map['String'] as String,
      seen: map['seen'] as bool,
      toUser: map['toUser'] as String,
      soLuong: map['soLuong'] as int,
    );
  }
}

class NotificationsSnapshot {
  Notifications notification;
  DocumentReference docRef;

  NotificationsSnapshot({required this.notification, required this.docRef});

  factory NotificationsSnapshot.fromDocSnap(DocumentSnapshot docSnap) {
    return NotificationsSnapshot(
      notification: Notifications.fromJson(docSnap.data() as Map<String, dynamic>),
      docRef: docSnap.reference
    );
  }

  static Future<DocumentReference> add(Notifications object) async {
    return await FirebaseFirestore.instance.collection(Firebase.colNotification).add(object.toJson());
  }

  Future<void> delete() async {
    await docRef.delete();
  }

  Future<void> update(Notifications object) async {
    await docRef.update(object.toJson());
  }

  static Stream<List<NotificationsSnapshot>> streamData() {
    var querySnapshot = FirebaseFirestore.instance.collection(Firebase.colNotification).where("toUser", isEqualTo: ChuonChuonKimController.instance.getId()).snapshots();
    var list = querySnapshot.map(
      (qsn) => qsn.docs.map(
        (docSnap) => NotificationsSnapshot.fromDocSnap(docSnap)
      ).toList()
    );

    return list;
  }

  static Future<List<NotificationsSnapshot>> futureData() async {
    var qs = await FirebaseFirestore.instance.collection(Firebase.colNotification).where("toUser", isEqualTo: ChuonChuonKimController.instance.getId()).get();

    var list = qs.docs.map(
      (docSnap) => NotificationsSnapshot.fromDocSnap(docSnap)
    ).toList();

    return list;
  }
}

List<Notifications> dbNotifications = [];