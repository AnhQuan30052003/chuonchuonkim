import 'package:flutter/material.dart';

var card = Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: Colors.redAccent.withOpacity(0.5),
        width: 2,
      ),
  ),
  color: Colors.white,
  borderOnForeground: true,
);