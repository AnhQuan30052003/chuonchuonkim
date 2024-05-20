import 'package:flutter/material.dart';

void thongBaoDangThucHien({required BuildContext context, required String info}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(info),
      duration: const Duration(seconds: 30),
    )
  );
}

void thongBaoThucHienXong({required BuildContext context, required String info}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(info),
      duration: const Duration(seconds: 1),
    )
  );
}

Future<String> khungLuaChon({required BuildContext context, required List<String> listLuaChon, required String cauHoi}) async {
  String chonCuoiCung = "";
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Center(
        child: Text("Thông báo", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      content: Text(cauHoi),
      actions: listLuaChon.map(
        (luaChon) => ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            chonCuoiCung = luaChon;
          },
          child: Text(luaChon)
        )
      ).toList()
    )
  );
  return chonCuoiCung;
}