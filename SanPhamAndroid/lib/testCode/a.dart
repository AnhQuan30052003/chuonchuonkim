

void main() {
  List<String> list = ["Anh Quân", "Trung Quân", "Văn Đồng"];
  String search = "quân";

  for (var l in list) {
    if (l.toLowerCase().contains(search.toLowerCase())) {
      print(l);
    }
  }
}