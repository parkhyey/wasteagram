// import 'package:flutter/material.dart';
// import '../models/food_waste_post.dart';

// class CameraFab extends StatelessWidget {

//   const CameraFab({
//     Key? key, @required this.singlePost}) : super(key: key);

//   final FoodWastePost singlePost;

//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
    
//       singlePost.url,
//       scale: 0.5,
//       loadingBuilder: (BuildContext context, Widget child,
//           ImageChunkEvent loadingProgress) {
//             if (loadingProgress == null) return child;
//             return Center(
//               child: CircularProgressIndicator(
//                 value: loadingProgress.expectedTotalBytes != null
//                     ? loadingProgress.cumulativeBytesLoaded /
//                         loadingProgress.expectedTotalBytes
//                     : null,
//               ),
//             );
//           },
//     );
//   }
// }