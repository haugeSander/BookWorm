import 'dart:io';

import 'package:book_worm/states/book_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailHeader extends StatelessWidget {
  const BookDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(builder: (context, state, child) {
      var book = state.book;
      return SizedBox(
        height: 175, // Fixed height for the header
        child: Stack(
          children: [
            Positioned.fill(
              child: book.coverImage != ""
                  ? Image.file(
                      File(book.coverImage),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey,
                    ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: _buildHeaderCard(context, state),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeaderCard(BuildContext context, BookDetailState state) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  state.isEditMode
                      ? TextFormField(
                          initialValue: state.book.title,
                          onChanged: (value) => state.updateBookTitle(value),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )
                      : Text(
                          state.book.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  state.isEditMode
                      ? TextFormField(
                          initialValue: state.book.author,
                          onChanged: (value) => state.updateBookAuthor(value),
                          style: const TextStyle(fontSize: 18.0),
                        )
                      : Text(
                          state.book.author,
                          style: const TextStyle(fontSize: 18.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 40,
              onPressed: () => state.navigateBack(context),
            ),
          ],
        ),
      ),
    );
  }
}
