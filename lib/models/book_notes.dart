import 'package:book_worm/models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

part 'book_notes.g.dart';

@Collection()
class BookNotes {
  Id noteId = Isar.autoIncrement;
  DateTime timeOfNote;
  String noteContent;

  @Backlink(to: "bookNote")
  final bookReference = IsarLink<Book>();

  BookNotes({
    required this.timeOfNote,
    required this.noteContent,
  });
}
