import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      home: PageTestPosition(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    double w = 190, h = 220, c = 130;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thí nghiệm khung sản phẩm")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: h * 0.5,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: h * 0.45,
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Tên sản phẩm"),
                                Text("Mô tả..........."),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("12000đ"),
                                Icon(Icons.favorite),
                              ]
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 30,
                top: 0,
                child: SizedBox(
                  width: c,
                  height: c,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1)
                    ),
                    child: ClipOval(
                        child: Image.asset("assets/products/bun_1.jpg", fit: BoxFit.cover)
                    )
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class PageTestPosition extends StatefulWidget {
  const PageTestPosition({super.key});

  @override
  State<PageTestPosition> createState() => _PageTestPositionState();
}

class _PageTestPositionState extends State<PageTestPosition> {
  @override
  Widget build(BuildContext context) {
    double w = 190, h = 230, c = 130;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Position"),
      ),
      body: Center(
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.red)
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 30,
                  ),
                  Container(
                    width: w,
                    height: h-35,
                    color: Colors.green,
                  ),
                ],
              ),
              Positioned(
                height: h,
                width: double.infinity,
                top: -50,
                child: Center(
                  child: Container(
                    width: c,
                    height: c,
                    // color: Colors.yellow,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipOval(child: Image.asset("assets/products/bun_1.jpg", fit: BoxFit.cover)),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
