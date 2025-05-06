import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/features/theme/cubit/theme_cubit.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const ProfileSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        color: AppColors.white(context),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  InkWell(
                    onTap: items[i]['onTap'] ?? () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Icon(items[i]['icon'], color: AppColors.primaryColor),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              items[i]['label'],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          if (items[i]['label'] == 'Mode')
                            Switch(
                              value: context.read<ThemeCubit>().state,
                              onChanged: (value) {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                              activeColor: AppColors.primaryColor,
                              activeTrackColor: AppColors.secondaryColor,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.white,
                            )
                          else
                            const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                  if (i < items.length - 1) const Divider(thickness: .5),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
