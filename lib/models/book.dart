import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'book_notes.dart';

part 'book.g.dart';

enum BookStatus { finished, started, added, dropped }

@Collection()
class Book {
  Id bookId = Isar.autoIncrement;
  String title;
  String author;
  @enumerated
  BookStatus status;
  String coverImage;
  bool? asAudioBook;
  final bookNote = IsarLink<BookNotes>();

  Book({
    required this.title,
    required this.author,
    required this.status,
    required this.coverImage,
  });
}
