import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          PageViewItem(
            isVisible: true,
            imagePath: Assets.assetsImagesOnboarding1,
            background: Assets.assetsImagesOnboarding1,
            subtitle:
                'A Dynamic Multi-Category Platform for Strengthening Connections Between Services and Expanding Opportunities with smart Image Classification for Jop Creation',
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Wa',
                        style: TextStyle(
                          color: Color(0xFFF05D3B),
                          fontSize: 64,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w700,
                          height: 1.30,
                          letterSpacing: -1.28,
                        ),
                      ),
                      TextSpan(
                        text: 'sset',
                        style: TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 64,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w700,
                          height: 1.30,
                          letterSpacing: -1.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PageViewItem(
            isVisible: false,

            imagePath: Assets.assetsImagesOnboarding2,
            background: Assets.assetsImagesOnboarding1,
            subtitle:
                'Discover a world of timeless fashion for the modern People. Shop the latest collections from top designers.',
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Shopping made ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xFF374151),
                        fontSize: 40,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Easy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: AppColors.primaryColor,
                        fontSize: 40,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
