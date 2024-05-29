import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "App",
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}


class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController txtUser = TextEditingController();
    TextEditingController txtPass = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Đăng nhập")
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: txtUser,
              decoration: const InputDecoration(
                labelText: "Tên đăng nhập"
              ),
            ),

            space(0, 10),
            TextField(
              controller: txtPass,
              obscureText: showPass,
              decoration: const InputDecoration(
                labelText: "Mật khẩu"
              ),
            ),

          ],
        ),
      ),
    );
  }
}
