import 'package:flutter/material.dart';

class PageLoad extends StatelessWidget {
  const PageLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/logo.png", height: 85),
            ),
          ],
        ),
      ),
    );
  }
}
