import 'package:chuonchuonkim_app/controllers/counterQuantityProductController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "App", debugShowCheckedModeBanner: false, home: Page());
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
                child: const Text("Click or Press"))
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
        CounterQuantityProductController quantity = CounterQuantityProductController(0);
        return SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      quantity.decrement();
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Obx(() => Text("${quantity.count.value}")),
                  IconButton(
                    onPressed: () {
                      quantity.increment();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.redAccent))),
                onPressed: () {},
                child: const Text(
                  "Mua",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        );
      });
}
