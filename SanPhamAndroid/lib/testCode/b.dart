import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestFull(1),
    );
  }
}

class TestFull extends StatefulWidget {
  final int cnt;
  const TestFull(this.cnt, {super.key});

  @override
  State<TestFull> createState() => _TestFullState();
}

class _TestFullState extends State<TestFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.cnt}"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                int num = widget.cnt + 1;
                setState(() {});
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TestFull(num),
                ));
              },
              child: const Text("click"),
            )
          ],
        ),
      ),
    );
  }
}
