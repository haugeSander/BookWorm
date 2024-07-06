import 'dart:io';
import 'package:book_worm/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  late Color color;

  BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    color = _getCorrespondingColor(book);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          const SizedBox(height: 16.0),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  Chip(
                    label: Text(
                      book.status.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: color),
                    ),
                    backgroundColor: color,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Stack _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(book.coverImage)), fit: BoxFit.cover)),
        ),
        // Overlay card with title, author and back button
        Positioned(
          top: 30,
          left: 8,
          right: 8,
          child: Card(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        Text(
                          book.author,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Color _getCorrespondingColor(Book book) {
    switch (book.status) {
      case BookStatus.finished:
        return Colors.green;
      case BookStatus.reading:
        return Colors.teal;
      case BookStatus.listening:
        return Colors.amber;
      case BookStatus.dropped:
        return Colors.red;
      case BookStatus.added:
        return Colors.black;
    }
  }

  Widget _getCorrespondingIcon(Book book) {
    switch (book.status) {
      case BookStatus.finished:
        return const Icon(Icons.check);
      case BookStatus.reading:
        return SvgPicture.asset("assets/icons/reading_icon.svg",
            width: 24.0, height: 24.0);
      case BookStatus.listening:
        return const Icon(Icons.headphones);
      case BookStatus.dropped:
        return const Icon(Icons.block_outlined);
      case BookStatus.added:
        return SvgPicture.asset("assets/icons/added_icon.svg",
            width: 24.0, height: 24.0);
    }
  }
}
