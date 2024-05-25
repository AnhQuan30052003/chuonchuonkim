import 'package:chuonchuonkim_app/database/connect/setupFirebase.dart';
import 'package:chuonchuonkim_app/database/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import '../../helper/widget.dart';

List<String> listTen = [
  "Hà Nội", "Hồ Chí Minh", "Nghệ An", "Vũng Tàu", "5 ngon",
  "Phú Quốc", "Vạn Giã", "Xuân Bắc", "Khánh Hoà", "Thái Nguyên",
];

List<String> hinhAnhBun = [
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_1.jpg?alt=media&token=6bb1c591-e095-4c4b-963a-ffbbf3c902e0",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_2.jpg?alt=media&token=c8a27309-a025-49b8-b6b6-38ed78022bf3",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_3.jpg?alt=media&token=65132c62-7b49-4dff-8fe2-c7db4d1e2298",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_4.jpg?alt=media&token=d04343a8-ea65-4b1d-8f75-414a10743ba9",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_5.jpg?alt=media&token=93c32b13-1941-46c4-ae19-5d0c2321ca8b",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_6.jpg?alt=media&token=6923cac0-d084-4061-b415-05f468aa2be6",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_7.jpg?alt=media&token=c9e792ba-834d-424f-991d-19faea6cbf37",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_8.jpg?alt=media&token=2e7fe7b1-9e57-4ea0-8523-298927559b73",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_9.jpg?alt=media&token=3f2a1dea-26b2-41ec-b4ac-43c6fa305a87",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fbun_10.jpg?alt=media&token=025fa83c-39ae-4e45-86d8-ae8f2bcfebcb",
];
List<String> hinhAnhHamburger = [
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_1.jpg?alt=media&token=1c14c9d9-6836-478c-af48-157c13f3dbb6",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_2.jpg?alt=media&token=4dfcd5a0-abe0-4ddd-b579-685d754d9f9a",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_3.jpg?alt=media&token=0b78bd33-d972-446a-bf46-8fdf03e932a7",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_4.jpg?alt=media&token=b52f8180-c090-4f26-90d8-d6a121c849f8",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_5.jpg?alt=media&token=3e57f9e5-e298-45c0-8e9c-c52d04adddc2",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_6.jpg?alt=media&token=781ed0c4-3bee-4636-8084-00724c268d2f",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_7.jpg?alt=media&token=c5e676ed-fbfe-4cf7-bde9-61170dd32dc4",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_8.jpg?alt=media&token=4f196d2d-422b-4bf3-8a5f-bd0a9b59727d",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fhamburger_9.jpg?alt=media&token=cad07a9f-6284-40bf-8027-1a4f6df03999",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_10.jpg?alt=media&token=dbfa36e6-47c8-4e6a-82db-197ded5f2e45",
];
List<String> hinhAnhPho = [
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_1.jpg?alt=media&token=8e75ea5a-a035-4aa9-a8e0-7fb49c64bb88",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_2.jpg?alt=media&token=ebbd0a8a-7498-4392-af80-6880ba92efce",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_3.jpg?alt=media&token=7cf5efbd-8d0e-45ea-9afd-eec84af7f369",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_4.jpg?alt=media&token=6aede1c6-9b9b-436c-8d60-67e41fa45820",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_5.jpg?alt=media&token=dcda3c2a-6cec-41de-b6ea-5a3fa86dcb61",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_6.jpg?alt=media&token=0a1aa568-0884-4d98-94a2-8d5a68f5550b",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_7.jpg?alt=media&token=7071d749-36da-40d5-b212-ad979f5acccc",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_8.jpg?alt=media&token=af4ef532-e7de-4c31-810b-2d0eca10fe83",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_9.jpg?alt=media&token=969072c6-414c-43c7-87fd-faa12b32e667",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpho_10.jpg?alt=media&token=7de51319-1650-4dc3-99fd-0bd4b246c7e4",
];
List<String> hinhAnhNuoc = [
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2F7up.jpg?alt=media&token=681d2e4f-fe56-4d15-9b02-b8f8eca105c8",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fc2.jpg?alt=media&token=838ab0b7-e650-4fc3-9d45-9ef289fe4c34",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcoca.jpg?alt=media&token=e6729faa-11c3-42cf-a790-63c89efe724d",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fpepsi.jpg?alt=media&token=38bfbc7b-b650-4b50-b1ec-e2e1ecc75936",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsting.jpg?alt=media&token=b591b4bb-8a4a-45f2-8223-eb99e0cd1ee0",
];
List<String> hinhAnhComSuon = [
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_1.jpg?alt=media&token=50785550-685e-4903-9497-3c675431f35d",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_2.jpg?alt=media&token=e7790c59-d93f-47cd-9e23-24f66fa1b68b",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_3.jpg?alt=media&token=bdd2f001-3707-4f7c-bea7-e058d7fd3eaa",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_4.jpg?alt=media&token=a800269d-3cbf-4e39-bb78-58a044dcd1bb",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_5.jpg?alt=media&token=5ff270e7-d220-4853-b09f-f92e403b692c",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_6.jpg?alt=media&token=2a6a9bad-5ddc-4cae-87c8-9bf1e7ac0802",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_7.jpg?alt=media&token=1a1f976a-a593-48ad-82fc-fe41ec408dca",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_8.jpg?alt=media&token=4618203c-3f96-4863-ab0d-f819df3f3136",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_9.jpg?alt=media&token=690f7ec3-f82a-4540-a35f-702aef4e726b",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fcom_suon_10.jpg?alt=media&token=dbfa36e6-47c8-4e6a-82db-197ded5f2e45",
];
List<String> hinhAnhSalad = [
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_1.png?alt=media&token=4322777a-1540-4a36-8998-bd7827467799",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_2.png?alt=media&token=4c3ac91d-b1b1-49cb-ba6a-f76a01bcc3eb",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_3.png?alt=media&token=e81342f6-406f-472a-9378-fd5a41542b9c",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_4.png?alt=media&token=557f3c0c-33ac-4b1b-b774-7827dbe4efdb",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_5.png?alt=media&token=10ed6877-1239-451b-977c-baf38b2c9cd4",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_6.png?alt=media&token=ca9d7824-eac1-43a1-bfc9-dacdaf750138",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_7.png?alt=media&token=0b17e769-f903-4af8-b361-3c11888186b1",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_8.png?alt=media&token=0009201b-127c-431e-8b63-d2af51ab33d4",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_9.png?alt=media&token=876187da-09de-4634-bf62-8aa13d5a623d",
  "https://firebasestorage.googleapis.com/v0/b/chuonchuonkim-a7c61.appspot.com/o/ChuonChuonKimApp%2FProducts%2Fsalad_10.png?alt=media&token=f3d5030e-1392-49cb-8ed8-69522fab7d3f",
];

void buildProduct({required int soLuongTao, required String tenSPTao, required List<String> hinhAnhSPTao, required List<int> giaSPTao, required String maLSPTao}) {
  String maSP, tenSP, moTaSP, hinhAnhSP, maLSP;
  int giaSP;

  moTaSP = "$tenSPTao ngon từ Việt Nam";
  maLSP = maLSPTao;

  for (int i = 0; i < soLuongTao; i++) {
    maSP = getIdToString(Firebase.id++);
    tenSP = "$tenSPTao ${listTen[Random().nextInt(listTen.length)]}";
    giaSP = giaSPTao[Random().nextInt(giaSPTao.length)];
    hinhAnhSP = hinhAnhSPTao[Random().nextInt(hinhAnhSPTao.length)];
    dbProduct.add(Product(maSP: maSP, tenSP: tenSP, moTaSP: moTaSP, hinhAnhSP: hinhAnhSP, giaSP: giaSP, maLSP: maLSP));
  }
}

Future<void> deleteData({required String collectionPath}) async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionPath);
  QuerySnapshot querySnapshot = await collectionRef.get();
  List<Future> deleteFutures = querySnapshot.docs.map((doc) => doc.reference.delete()).toList();
  await Future.wait(deleteFutures);
  print("Collection $collectionPath đã được xóa thành công");
}