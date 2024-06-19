import 'package:isar/isar.dart';
import 'book_notes.dart';

part 'book.g.dart';

@Collection()
class Book {
  Id bookId = Isar.autoIncrement;
  String name;
  String author;
  bool boxIsSelected = false;
  bool? isFiction;
  final bookNote = IsarLink<BookNotes>();

  Book({
    required this.name,
    required this.author,
  });
}
