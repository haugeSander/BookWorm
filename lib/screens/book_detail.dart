import 'dart:io';

import 'package:book_worm/models/book.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            book.coverImage == ""
                ? const SizedBox(
                    width: 200.0,
                    height: 300.0,
                    child: Card(child: Center(child: Text('No image'))),
                  )
                : Image.file(
                    File(book.coverImage),
                    width: 200,
                    height: 300,
                  ),
            const SizedBox(height: 16.0),
            Text(
              book.title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Author: ${book.author}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Status: ${book.status == BookStatus.finished ? "Finished" : "Not Finished"}",
              style: const TextStyle(fontSize: 18.0),
            ),
            // Add more book details here
          ],
        ),
      ),
    );
  }
}
