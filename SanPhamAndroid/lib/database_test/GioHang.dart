class GioHang {
  String maGH;
  String maSP; // khoá ngoại
  int soLuong;

  GioHang({
    required this.maGH,
    required this.maSP,
    required this.soLuong,
  });
}

List<GioHang> dbGioHang = [
  GioHang(maGH: "GH001", maSP: "SP001", soLuong: 1),
  GioHang(maGH: "GH001", maSP: "SP001", soLuong: 1),
  GioHang(maGH: "GH001", maSP: "SP001", soLuong: 1),
];