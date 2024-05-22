// * card product
// SizedBox(
//   height: 250,
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: list.length,
//     shrinkWrap: true,
//     itemBuilder: (context, index) {
//       var item = list[index];
//       return Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Container(
//               margin: const EdgeInsets.all(10),
//               height: 250,
//               width: 190,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                     blurRadius: 4,
//                     spreadRadius: 2,
//                     color: Colors.black12,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     const SizedBox(height: 7),
//                     Text(
//                       item.tenSP,
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       item.moTaSP,
//                       style: const TextStyle(color: Colors.black45, fontSize: 15),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "${item.giaSP}đ",
//                           style: const TextStyle(fontWeight: FontWeight.normal),
//                         ),
//                         Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(
//                             color: Colors.black12,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(Icons.favorite_border_outlined),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 35,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(80),
//                 boxShadow: const [
//                   BoxShadow(
//                     blurRadius: 4,
//                     spreadRadius: 2,
//                     color: Colors.black12,
//                   )
//                 ],
//               ),
//               child: Image.network(
//                 item.hinhAnhSP,
//                 height: 140,
//                 width: 140,
//               ),
//             ),
//           )
//         ],
//       );
//     },
//   ),
// ),
// * end card product

// const SizedBox(height: 10),
// const Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       "Sản phẩm",
//       style: TextStyle(
//         color: Colors.black87,
//         fontSize: 17,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ],
// ),

// const SizedBox(height: 10),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     const Text(
//       "Phổ biến",
//       style: TextStyle(
//         color: Colors.black87,
//         fontSize: 17,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     GestureDetector(
//       onTap: () {},
//       child: const Text(
//         "Tất cả",
//         style: TextStyle(color: Colors.redAccent, fontSize: 15),
//       ),
//     ),
//   ],
// ),



// GridView.extent(
//   maxCrossAxisExtent: 300, // chiều rộng lớn nhất
//   crossAxisSpacing: 5,
//   mainAxisSpacing: 5,
//   shrinkWrap: true,
//   children: controller.listProduct
//     .map((product) => GestureDetector(
//       onTap: () {
//         Get.to(() => PageDetails(product: product));
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: BorderSide(
//             color: Colors.redAccent.withOpacity(0.5),
//             width: 2,
//           ),
//         ),
//         color: Colors.white,
//         borderOnForeground: true,
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   Expanded(child: Image.network(product.hinhAnhSP)),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product.tenSP,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 15
//                         ),
//                       ),
//                       Text(product.moTaSP),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${product.giaSP}",
//                             style: const TextStyle(
//                               fontSize: 15,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold
//                             ),
//                           ),
//                           Container(
//                             height: 30,
//                             width: 30,
//                             decoration: BoxDecoration(
//                               color: Colors.black12,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: const Icon(
//                               Icons.favorite_border_outlined
//                             ),
//                           ),
//                         ],
//                       )
//                   ],
//                         )
//                 ],
//               ),
//             ),
//           ),
//         ),
//     )).toList(),