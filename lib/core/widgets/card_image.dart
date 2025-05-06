import 'package:flutter/material.dart';
import 'package:e_commerce/core/widgets/custom_network_image.dart';

class CardImage extends StatelessWidget {
  final String? imageUrl;
  const CardImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child:
            (imageUrl != null && imageUrl!.isNotEmpty)
                ? CustomNetworkImage(imageUrl: imageUrl!)
                : Container(
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
      ),
    );
  }
}
