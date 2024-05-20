import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "App",
      debugShowCheckedModeBanner: false,
      home: Page()
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo BottomSheet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                String name = "close";
                show(context, name);
              },
              child: const Text("Click or Press")
            )
          ],
        ),
      ),
    );
  }
}

void show(BuildContext context, String text) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
          height: 100,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(text),
            ),
          ),
        );
    }
  );
}

