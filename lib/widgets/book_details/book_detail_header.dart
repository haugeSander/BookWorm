import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:book_worm/widgets/book_cover_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailHeader extends StatelessWidget {
  const BookDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(builder: (context, state, child) {
      final topPadding = MediaQuery.of(context).padding.top;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 280,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Cover image or placeholder
                _buildCoverBackground(state),
                // Gradient overlay at bottom for depth
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 1.0],
                      colors: [
                        Colors.transparent,
                        Color(0x66000000),
                      ],
                    ),
                  ),
                ),
                // Back button
                Positioned(
                  top: topPadding + 8,
                  left: 8,
                  child: Material(
                    color: Colors.black38,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => state.navigateBack(context),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ),
                // Camera button (edit mode only)
                if (state.isEditMode)
                  Positioned(
                    top: topPadding + 8,
                    right: 8,
                    child: Material(
                      color: Colors.black38,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => state.updateCoverImage(context),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.photo_camera, color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Title and author below the image
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.isEditMode
                    ? TextFormField(
                        initialValue: state.title,
                        onChanged: state.updateTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: AppTheme.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Tittel',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      )
                    : Text(
                        state.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: AppTheme.textPrimary,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                const SizedBox(height: 4),
                state.isEditMode
                    ? TextFormField(
                        initialValue: state.author,
                        onChanged: state.updateAuthor,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppTheme.textSecondary,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Forfatter',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      )
                    : Text(
                        state.author,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCoverBackground(BookDetailState state) {
    if (state.coverImage.isNotEmpty || state.book.coverUrl != null) {
      return BookCoverImage(
        coverImage: state.coverImage,
        coverUrl: state.book.coverUrl,
        fit: BoxFit.cover,
      );
    }
    return Container(
      color: AppTheme.primary.withValues(alpha: 0.25),
      child: const Center(
        child: Icon(Icons.menu_book, color: Colors.white, size: 72),
      ),
    );
  }
}
