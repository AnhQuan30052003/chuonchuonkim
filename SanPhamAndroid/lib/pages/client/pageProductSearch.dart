import 'package:flutter/material.dart';
import '../../helper/widget.dart';
import '../../helper/widgetClient.dart';

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
              buildSearch(context: context, search: ""),
              space(0, 10),
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
