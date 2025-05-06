// import 'package:flutter/material.dart';
// import 'package:e_commerce/features/home/domain/entites/bottom_navigation_bar_entity.dart';
// import 'package:e_commerce/core/utils/app_colors.dart';

// class AnimatedNavBarItem extends StatelessWidget {
//   const AnimatedNavBarItem({
//     super.key,
//     required this.isSelected,
//     required this.bottomNavigationBarEntity,
//   });

//   final bool isSelected;
//   final BottomNavigationBarEntity bottomNavigationBarEntity;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // الأيقونة (ثابتة تمامًا)
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primaryColor : Colors.transparent,
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: Image.asset(
//               isSelected
//                   ? bottomNavigationBarEntity.activeImage
//                   : bottomNavigationBarEntity.inActiveImage,
//             ),
//           ),
//         ),

//         // الخلفية والنص (الكود الخاص بك مع الأنيميشن)
//         ClipRect(
//           child: TweenAnimationBuilder<Offset>(
//             tween: Tween(
//               begin: Offset(-0.5, 0),
//               end: isSelected ? Offset(0, 0) : Offset(-0.5, 0),
//             ),
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//             builder: (context, offset, child) {
//               return FractionalTranslation(translation: offset, child: child);
//             },
//             child:
//                 isSelected
//                     ? Container(
//                       padding: EdgeInsets.only(right: 16),
//                       margin: EdgeInsets.only(left: 4),
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFEEEEEE),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Text(
//                         bottomNavigationBarEntity.name,
//                         style: TextStyle(
//                           color: AppColors.primaryColor,
//                           fontSize: 12,
//                           fontFamily: 'Cairo',
//                           fontWeight: FontWeight.bold,
//                           height: 1.40,
//                         ),
//                       ),
//                     )
//                     : SizedBox(),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/home/domain/entites/bottom_navigation_bar_entity.dart';
import 'package:flutter/material.dart';

class AnimatedNavBarItem extends StatelessWidget {
  const AnimatedNavBarItem({
    super.key,
    required this.image,
    required this.name,
    required this.isSelected,
    required this.bottomNavigationBarEntity,
  });
  final String image;
  final String name;
  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarEntity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        decoration: ShapeDecoration(
          color: Color(0xFFEEEEEE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: TweenAnimationBuilder<Offset>(
          tween: Tween(
            begin: Offset(-0.5, 0),
            end: isSelected ? Offset(0, 0) : Offset(-0.5, 0),
          ),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
          builder: (context, offset, child) {
            return FractionalTranslation(translation: offset, child: child);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,

                decoration: ShapeDecoration(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Center(child: Image.asset(image)),
              ),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  name,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    height: 1.40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
