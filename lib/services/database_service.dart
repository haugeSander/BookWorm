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

  Stream<List<BookWidget>> watchBookWidgets(int bookId) {
    return (_db.select(_db.bookWidgets)
          ..where((w) => w.bookId.equals(bookId))
          ..orderBy([(w) => OrderingTerm.asc(w.sortOrder)]))
        .watch();
  }

  Future<int> addBookWidget({
    required int bookId,
    required String type,
    required String payloadJson,
  }) async {
    final existing = await (_db.select(_db.bookWidgets)
          ..where((w) => w.bookId.equals(bookId))
          ..orderBy([(w) => OrderingTerm.desc(w.sortOrder)])
          ..limit(1))
        .getSingleOrNull();
    final now = DateTime.now().millisecondsSinceEpoch;

    return _db.into(_db.bookWidgets).insert(
          BookWidgetsCompanion.insert(
            bookId: bookId,
            type: type,
            payloadJson: payloadJson,
            sortOrder: (existing?.sortOrder ?? -1) + 1,
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<void> updateBookWidgetPayload(int id, String payloadJson) {
    return (_db.update(_db.bookWidgets)..where((w) => w.id.equals(id))).write(
      BookWidgetsCompanion(
        payloadJson: Value(payloadJson),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> deleteBookWidget(int id) =>
      (_db.delete(_db.bookWidgets)..where((w) => w.id.equals(id))).go();

  Future<void> reorderBookWidgets(List<BookWidget> widgets) async {
    await _db.batch((batch) {
      for (var i = 0; i < widgets.length; i++) {
        batch.update(
          _db.bookWidgets,
          BookWidgetsCompanion(sortOrder: Value(i)),
          where: (w) => w.id.equals(widgets[i].id),
        );
      }
    });
  }

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
    final widgets = await _db.select(_db.bookWidgets).get();
    final widgetsByBook = <int, List<BookWidget>>{};
    for (final widget in widgets) {
      widgetsByBook.putIfAbsent(widget.bookId, () => []).add(widget);
    }

    final list = books.map((b) {
      final bookWidgets = widgetsByBook[b.id] ?? [];
      bookWidgets.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

      return {
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
        'widgets': bookWidgets
            .map((w) => {
                  'type': w.type,
                  'payloadJson': w.payloadJson,
                  'sortOrder': w.sortOrder,
                  'createdAt': w.createdAt,
                  'updatedAt': w.updatedAt,
                })
            .toList(),
      };
    }).toList();
    return jsonEncode(list);
  }

  Future<void> importFromJson(String jsonString) async {
    final list = jsonDecode(jsonString) as List<dynamic>;
    await _db.transaction(() async {
      await _db.delete(_db.bookWidgets).go();
      await _db.delete(_db.books).go();
      for (final item in list) {
        final bookId = await _db.into(_db.books).insert(BooksCompanion(
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

        final widgets = item['widgets'] as List<dynamic>?;
        if (widgets == null) {
          final legacyNotesPayload = _legacyNotesPayload(item);
          if (legacyNotesPayload != null) {
            await _db.into(_db.bookWidgets).insert(BookWidgetsCompanion.insert(
                  bookId: bookId,
                  type: 'notes',
                  payloadJson: legacyNotesPayload,
                  sortOrder: 0,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  updatedAt: DateTime.now().millisecondsSinceEpoch,
                ));
          }
          continue;
        }

        for (final widget in widgets) {
          await _db.into(_db.bookWidgets).insert(BookWidgetsCompanion.insert(
                bookId: bookId,
                type: widget['type'] as String,
                payloadJson: widget['payloadJson'] as String,
                sortOrder: widget['sortOrder'] as int? ?? 0,
                createdAt: widget['createdAt'] as int? ??
                    DateTime.now().millisecondsSinceEpoch,
                updatedAt: widget['updatedAt'] as int? ??
                    DateTime.now().millisecondsSinceEpoch,
              ));
        }
      }
    });
  }

  String? _legacyNotesPayload(Map<String, dynamic> item) {
    final hasNotes = [
      item['note'],
      item['inThreeSentences'],
      item['impressions'],
      item['whoShouldRead'],
      item['howChangedMe'],
      item['topThreeQuotes'],
      item['tags'],
    ].any((value) => value is String && value.isNotEmpty);

    if (!hasNotes) return null;

    return jsonEncode({
      'note': item['note'] as String?,
      'inThreeSentences': _decodeJsonList(item['inThreeSentences'] as String?),
      'impressions': item['impressions'] as String?,
      'whoShouldRead': item['whoShouldRead'] as String?,
      'howChangedMe': item['howChangedMe'] as String?,
      'topThreeQuotes': _decodeJsonList(item['topThreeQuotes'] as String?),
      'tags': _decodeJsonList(item['tags'] as String?),
    });
  }

  List<String> _decodeJsonList(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>).cast<String>();
    } catch (_) {
      return [];
    }
  }
}
