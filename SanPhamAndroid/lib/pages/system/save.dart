

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