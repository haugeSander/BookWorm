import 'package:isar/isar.dart';
import 'book_notes.dart';

part 'book.g.dart';

@Collection()
class Book {
  Id bookId = Isar.autoIncrement;
  String name;
  String author;
  bool boxIsSelected;
  bool? isFiction;
  final bookNote = IsarLink<BookNotes>();

  Book({
    required this.name,
    required this.author,
    required this.boxIsSelected,
  });

  static List<Book> getBooks() {
    List<Book> categories = [];

    categories.add(Book(
        name: 'Atomic Habits', author: 'James Clear', boxIsSelected: false));

    categories.add(Book(
        name: 'Rich dad poor dad',
        author: 'Robert Kiyosaki',
        boxIsSelected: false));

    categories
        .add(Book(name: 'Power', author: 'Robert Greene', boxIsSelected: true));

    categories
        .add(Book(name: 'Power', author: 'Robert Greene', boxIsSelected: true));

    return categories;
  }
}
