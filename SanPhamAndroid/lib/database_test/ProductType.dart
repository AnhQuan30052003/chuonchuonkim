class ProductType {
  String maLSP, tenLSP;

  ProductType({
    required this.maLSP,
    required this.tenLSP,
  });
}

List<ProductType> dbProductType = [
  ProductType(maLSP: "LSP001", tenLSP: "Đồ ăn"),
  ProductType(maLSP: "LSP002", tenLSP: "Nước uống")
];