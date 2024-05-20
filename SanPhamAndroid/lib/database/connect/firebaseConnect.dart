import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// class kết nối Flutter với Firebase
class FirebaseConnect extends StatefulWidget {
  final String errorMessage, connectingMessage;
  final Widget Function(BuildContext context) builder;

  const FirebaseConnect({
    required this.builder,
    this.errorMessage = "Lỗi kết nối...",
    this.connectingMessage = "Đang kết nối...",
    super.key
  });

  @override
  State<FirebaseConnect> createState() => _FirebaseConnectState();
}

class _FirebaseConnectState extends State<FirebaseConnect> {
  bool _connect = false, _error = false;

  @override
  void initState() {
    super.initState();

    // Khởi tạo một app với điều chỉnh các trạng thái trong quá trình "kết nối"
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    ).then((value) {
      setState(() {
        _connect = true;
        print("Kết nối thành công");
      });
    })
    .catchError((error) {
      setState(() {
        _error = true;
        print("Kết nối có lỗi !");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nếu có lỗi trong quá trình kết nối
    if (_error) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            widget.errorMessage,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.red
            ),
            textDirection: TextDirection.ltr,
          )
        ),
      );
    }

    // Nếu kết nối được nhưng không có dữ liệu
    if (!_connect) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Text(
                widget.connectingMessage,
                style: const TextStyle(fontSize: 16),
                textDirection: TextDirection.ltr,
              )
            ],
          )
        ),
      );
    }

    // Trả về widget trong hàm builder()
    return widget.builder(context);
  }
}
