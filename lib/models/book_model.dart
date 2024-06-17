import 'dart:ffi';

import 'book_notes_model.dart';

class BookModel {
  int bookId;
  String name;
  String author;
  bool boxIsSelected;
  bool? isFiction;
  Array? genres;
  BookNotes? bookNotes;

  BookModel({
    required this.bookId,
    required this.name,
    required this.author,
    required this.boxIsSelected,
  });

  static List<BookModel> getBooks() {
    List<BookModel> categories = [];

    categories.add(BookModel(
        bookId: 1,
        name: 'Atomic Habits',
        author: 'James Clear',
        boxIsSelected: false));

    categories.add(BookModel(
        bookId: 1,
        name: 'Rich dad poor dad',
        author: 'Robert Kiyosaki',
        boxIsSelected: false));

    categories.add(BookModel(
        bookId: 1,
        name: 'Power',
        author: 'Robert Greene',
        boxIsSelected: true));

    return categories;
  }
}
