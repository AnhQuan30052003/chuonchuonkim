import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

Future<String?> uploadImage({required String imagePath, required List<String> folders, required String fileName}) async {
  String downloadUrl;
  Reference reference = FirebaseStorage.instance.ref();
  for (String f in folders) {
    reference = reference.child(f);
  }
  reference = reference.child(fileName);

  final metadata = SettableMetadata(
    contentType: 'image/jpeg',
    customMetadata: {'picked-file-path': imagePath},
  );

  try {
    if (kIsWeb) {
      await reference.putData(await XFile(imagePath).readAsBytes(), metadata);
    } else {
      await reference.putFile(File(imagePath), metadata);
    }
    downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  } on FirebaseException catch (e) {
    print("Đã có lỗi trong quá trình upload image: $e");
    return Future.error("Lỗi upload ảnh !");
  }
}

Future<void> deleteImage({required List<String> folders, required String fileName}) async {
  Reference reference = FirebaseStorage.instance.ref();
  for (String f in folders) {
    reference = reference.child(f);
  }
  reference = reference.child(fileName);

  return await reference.delete();
}