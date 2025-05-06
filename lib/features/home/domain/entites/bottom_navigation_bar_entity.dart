import 'package:e_commerce/core/utils/app_images.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String name;

  BottomNavigationBarEntity({
    required this.activeImage,
    required this.inActiveImage,
    required this.name,
  });
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
  BottomNavigationBarEntity(
    activeImage: Assets.assetsImagesBoldHome,
    inActiveImage: Assets.assetsImagesOutlineHome,
    name: 'Home',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.assetsImagesBoldShoppingCart,
    inActiveImage: Assets.assetsImagesOutlineShoppingCart,
    name: 'Cart',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.assetsImagesBoldElement,
    inActiveImage: Assets.assetsImagesOutlineElement,
    name: 'Products',
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.assetsImagesBoldUser,
    inActiveImage: Assets.assetsImagesOutlineUser,
    name: 'Profile',
  ),
];
