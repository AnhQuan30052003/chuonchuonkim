class SanPham {
  String maSP, tenSP, moTaSP, hinhAnhSP;
  String maLSP; // khoá ngoại
  int giaSP, soLuongConSP;

  SanPham({
    required this.maSP,
    required this.tenSP,
    required this.moTaSP,
    required this.hinhAnhSP,
    required this.giaSP,
    required this.soLuongConSP,
    required this.maLSP,
  });
}

List<SanPham> dbSanPham = [];