// import 'package:e_commerce/features/home/domain/entites/bottom_navigation_bar_entity.dart';
// import 'package:e_commerce/features/home/presentation/views/widgets/naivation_bar_theme.dart';
// import 'package:flutter/material.dart';

// class CustomButtomNavigationBar extends StatefulWidget {
//   const CustomButtomNavigationBar({super.key});

//   @override
//   State<CustomButtomNavigationBar> createState() =>
//       _CustomButtomNavigationBarState();
// }

// class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 375,
//       height: 70,
//       decoration: ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         shadows: [
//           BoxShadow(
//             color: Color(0x19000000),
//             blurRadius: 25,
//             offset: Offset(0, -2),
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Row(
//         children:
//             bottomNavigationBarItems.asMap().entries.map((e) {
//               var index = e.key;
//               var entity = e.value;
//               return Expanded(
//                 flex: index == selectedIndex ? 3 : 2,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = index;
//                     });
//                   },
//                   child: NavigationBarItem(
//                     isSelected: index == selectedIndex,
//                     bottomNavigationBarEntity: entity,
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     );
//   }
// }
// class SupabaseStoargeService implements StoarageService, DatabaseService {
  //   static late Supabase _supabase;

  //   static createBucket(String bucketName) async {
  //     var buckets = await _supabase.client.storage.listBuckets();
  //     bool isBucketExists = false;
  //     for (var bucket in buckets) {
  //       if (bucket.name == bucketName) {
  //         isBucketExists = true;
  //         break;
  //       }
  //     }
  //     if (!isBucketExists) {
  //       await _supabase.client.storage.createBucket(bucketName);
  //     }
  //   }

  //   static initSupabase() async {
  //     _supabase = await Supabase.initialize(
  //       url: kSupabaseUrl,
  //       anonKey: kSupabaseKey,
  //     );
  //   }

  //   @override
  //   Future<String> uploadFile(File file, String path) async {
  //     String fileName = b.basename(file.path);
  //     String extensionName = b.extension(file.path);
  //     var result = await _supabase.client.storage
  //         .from(kSupabaseBucket)
  //         .upload('$path/$fileName.$extensionName', file);

  //     final String publicUrl = _supabase.client.storage
  //         .from(kSupabaseBucket)
  //         .getPublicUrl('$path/$fileName.$extensionName');
  //     return result;
  //   }
  // }
