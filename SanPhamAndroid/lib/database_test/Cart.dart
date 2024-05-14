class Cart {
  String maSP; // khoá ngoại
  int soLuong;

  Cart({
    required this.maSP,
    required this.soLuong,
  });
}

List<Cart> dbCart = [
  Cart(maSP: "SP001", soLuong: 1),
  Cart(maSP: "SP001", soLuong: 1),
  Cart(maSP: "SP001", soLuong: 1),
];