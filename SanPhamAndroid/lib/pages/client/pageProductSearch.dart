import 'package:flutter/material.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../helper/distance.dart';
import 'widgetClient.dart';

class PageProductSearch extends StatelessWidget {
  final String search;
  const PageProductSearch({required this.search,super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildBody() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              buildSearch(),
              distance(0, 10),
              buildGridViewProducts(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: buildAppBar(info: "Kết quả tìm kiếm"),
      body: buildBody(),
    );
  }
}
