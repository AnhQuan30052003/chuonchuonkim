class LoaiSanPham {
  String maLSP, tenLSP;

  LoaiSanPham({
    required this.maLSP,
    required this.tenLSP,
  });
}

List<LoaiSanPham> dbLoaiSanPham = [
  LoaiSanPham(maLSP: "LSP001", tenLSP: "Đồ ăn"),
  LoaiSanPham(maLSP: "LSP002", tenLSP: "Nước uống")
];