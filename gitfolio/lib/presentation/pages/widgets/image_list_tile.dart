import 'package:flutter/material.dart';
import 'package:gitfolio/presentation/utils/constants/app_dimensions.dart';
import 'package:gitfolio/presentation/utils/constants/app_fonts.dart';

class ImageListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final bool isItalicSubtitle;
  final VoidCallback? onTap;
  final Color? tileColor;

  const ImageListTile({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.isItalicSubtitle,
    this.onTap,
    this.tileColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppFonts.titleLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: AppFonts.titleMedium,
          fontStyle: isItalicSubtitle ? FontStyle.italic : FontStyle.normal,
        ),
      ),
      leading: Container(
        width: AppDimensions.bigSize,
        height: AppDimensions.bigSize,
        color: Colors.black12,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const _DefaultImage();
          },
          errorBuilder: (_, __, ___) => const _DefaultImage(),
        ),
      ),
      onTap: onTap,
    );
  }
}

class _DefaultImage extends StatelessWidget {
  const _DefaultImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.bigSize,
      height: AppDimensions.bigSize,
      color: Colors.black12,
    );
  }
}
