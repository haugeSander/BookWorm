import 'package:isar/isar.dart';
import 'user_book_entry.dart';

part 'book.g.dart';

@Collection()
class Book {
  Id bookId = Isar.autoIncrement;
  String title;
  String author;
  String coverImage;
  String? summary;

  final userDataReference = IsarLink<UserBookEntry>();

  Book({
    required this.title,
    required this.author,
    required this.coverImage,
    this.summary,
  });
}
