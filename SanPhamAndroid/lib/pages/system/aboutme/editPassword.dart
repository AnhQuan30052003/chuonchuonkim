import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space(0, 30),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mật khẩu cũ", style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(246, 248, 250, 1),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              space(0, 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mật khẩu mới", style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(246, 248, 250, 1),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              space(0, 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Xác nhận mật khẩu mới", style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(246, 248, 250, 1),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.all(20),
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          onPressed: () {},
          child: const Text("ĐỔI MẬT KHẨU", style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ),
    );
  }
}
