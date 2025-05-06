import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // 🔴 ANSI Red log
        print(
          '\x1B[31m❌ Failed to load image: $imageUrl\nError: $error\x1B[0m',
        );

        return Container(
          width: double.infinity,
          height: 100,
          color: Colors.grey.shade300,
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
        );
      },
    );
  }
}
