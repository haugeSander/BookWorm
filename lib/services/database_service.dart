import 'dart:convert';

import 'package:book_worm/database/app_database.dart';
import 'package:drift/drift.dart';

class DatabaseService {
  final AppDatabase _db;

  DatabaseService(this._db);

  /// Watch all books, optionally filtered by search text and/or status.
  Stream<List<Book>> watchAllBooks({String? search, String? status}) {
    return (_db.select(_db.books)
          ..where((b) {
            Expression<bool> condition = const Constant(true);
            if (status != null && status.isNotEmpty) {
              condition = condition & b.status.equals(status);
            }
            if (search != null && search.isNotEmpty) {
              final q = '%${search.toLowerCase()}%';
              condition = condition &
                  (b.title.lower().like(q) | b.author.lower().like(q));
            }
            return condition;
          })
          ..orderBy([(b) => OrderingTerm.desc(b.dateAdded)]))
        .watch();
  }

  Future<int> saveBook(BooksCompanion book) => _db.into(_db.books).insert(book);

  Future<void> updateBook(Book book) => _db.update(_db.books).replace(book);

  Future<void> deleteBook(int id) =>
      (_db.delete(_db.books)..where((b) => b.id.equals(id))).go();

  Future<Book?> findByIsbn(String isbn) {
    return (_db.select(_db.books)..where((b) => b.isbn.equals(isbn)))
        .getSingleOrNull();
  }

  Future<Book?> findByTitleAuthor(String title, String author) {
    return (_db.select(_db.books)
          ..where((b) =>
              b.title.lower().equals(title.toLowerCase()) &
              b.author.lower().equals(author.toLowerCase())))
        .getSingleOrNull();
  }

  Future<String> exportToJson() async {
    final books = await _db.select(_db.books).get();
    final list = books
        .map((b) => {
              'id': b.id,
              'title': b.title,
              'author': b.author,
              'coverImage': b.coverImage,
              'isbn': b.isbn,
              'status': b.status,
              'dateAdded': b.dateAdded,
              'dateStarted': b.dateStarted,
              'dateFinished': b.dateFinished,
              'rating': b.rating,
              'note': b.note,
              'description': b.description,
              'pageCount': b.pageCount,
              'publisher': b.publisher,
              'publishedYear': b.publishedYear,
              'coverUrl': b.coverUrl,
              'isNonFiction': b.isNonFiction,
              'inThreeSentences': b.inThreeSentences,
              'impressions': b.impressions,
              'whoShouldRead': b.whoShouldRead,
              'howChangedMe': b.howChangedMe,
              'topThreeQuotes': b.topThreeQuotes,
              'tags': b.tags,
            })
        .toList();
    return jsonEncode(list);
  }

  Future<void> importFromJson(String jsonString) async {
    final list = jsonDecode(jsonString) as List<dynamic>;
    await _db.transaction(() async {
      await _db.delete(_db.books).go();
      for (final item in list) {
        await _db.into(_db.books).insert(BooksCompanion(
              title: Value(item['title'] as String),
              author: Value(item['author'] as String),
              coverImage: Value(item['coverImage'] as String? ?? ''),
              isbn: Value(item['isbn'] as String?),
              status: Value(item['status'] as String),
              dateAdded: Value(item['dateAdded'] as int),
              dateStarted: Value(item['dateStarted'] as int?),
              dateFinished: Value(item['dateFinished'] as int?),
              rating: Value(item['rating'] as int?),
              note: Value(item['note'] as String?),
              description: Value(item['description'] as String?),
              pageCount: Value(item['pageCount'] as int?),
              publisher: Value(item['publisher'] as String?),
              publishedYear: Value(item['publishedYear'] as String?),
              coverUrl: Value(item['coverUrl'] as String?),
              isNonFiction: Value(item['isNonFiction'] as bool? ?? false),
              inThreeSentences: Value(item['inThreeSentences'] as String?),
              impressions: Value(item['impressions'] as String?),
              whoShouldRead: Value(item['whoShouldRead'] as String?),
              howChangedMe: Value(item['howChangedMe'] as String?),
              topThreeQuotes: Value(item['topThreeQuotes'] as String?),
              tags: Value(item['tags'] as String?),
            ));
      }
    });
  }
}
