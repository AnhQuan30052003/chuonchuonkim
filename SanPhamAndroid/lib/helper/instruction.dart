import 'package:flutter/material.dart';

Widget buildInstruction({required String text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}