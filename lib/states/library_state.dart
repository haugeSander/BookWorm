import 'package:flutter/material.dart';
import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/user_book_entry.dart';

class LibraryState extends ChangeNotifier {
  Book book;
  UserBookEntry userData;

  LibraryState({
    required this.book,
    required this.userData,
  });
}