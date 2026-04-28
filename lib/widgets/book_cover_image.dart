import 'dart:io';

import 'package:book_worm/utility/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCoverImage extends StatelessWidget {
  final String coverImage;
  final String? coverUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const BookCoverImage({
    super.key,
    required this.coverImage,
    required this.coverUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (coverImage.isNotEmpty) {
      final f = File(coverImage);
      if (f.existsSync()) {
        return Image.file(f, width: width, height: height, fit: fit);
      }
    }
    if (coverUrl != null && coverUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: coverUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, __) => _placeholder(),
        errorWidget: (_, __, ___) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => Container(
        width: width,
        height: height,
        color: AppTheme.surfaceVariant,
        child: const Center(
          child: Icon(Icons.menu_book, color: AppTheme.textSecondary, size: 28),
        ),
      );
}
