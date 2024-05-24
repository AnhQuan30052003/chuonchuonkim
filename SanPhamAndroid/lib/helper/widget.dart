import 'package:flutter/material.dart';

// Widget khoảng cách thay cho sử dụng nhiều lần SizedBox
Widget space([double w = 0, double h = 0]) {
  return SizedBox(width: w, height: h);
}

// Hiển thị ... khi chiều dài text > lengthMax
String shortText({required String text, required int lengthMax}) {
  if (text.length > lengthMax) {
    String textStranle = "";
    for (int i = 0; i < lengthMax; i++) {
      textStranle += text[i];
    }
    return "$textStranle...";
  }
  return text;
}