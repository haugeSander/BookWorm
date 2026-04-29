import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get coverImage => text().withDefault(const Constant(''))();
  TextColumn get isbn => text().nullable()();
  // 'lest' | 'leser' | 'skalLese' | 'droppet'
  TextColumn get status => text()();
  IntColumn get dateAdded => integer()();
  IntColumn get dateStarted => integer().nullable()();
  IntColumn get dateFinished => integer().nullable()();
  IntColumn get rating => integer().nullable()(); // 1–5
  TextColumn get note => text().nullable()();

  // Metadata from API (added in schema v2)
  TextColumn get description => text().nullable()();
  IntColumn get pageCount => integer().nullable()();
  TextColumn get publisher => text().nullable()();
  TextColumn get publishedYear => text().nullable()();
  TextColumn get coverUrl => text().nullable()(); // remote image URL
  BoolColumn get isNonFiction => boolean().withDefault(const Constant(false))();

  // Structured non-fiction notes (lists stored as JSON, added in schema v2)
  TextColumn get inThreeSentences => text().nullable()();
  TextColumn get impressions => text().nullable()();
  TextColumn get whoShouldRead => text().nullable()();
  TextColumn get howChangedMe => text().nullable()();
  TextColumn get topThreeQuotes => text().nullable()();
  TextColumn get tags => text().nullable()();
}

class BookWidgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId =>
      integer().references(Books, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  TextColumn get payloadJson => text()();
  IntColumn get sortOrder => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

@DriftDatabase(tables: [Books, BookWidgets])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) => migrator.createAll(),
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(books, books.description);
            await migrator.addColumn(books, books.pageCount);
            await migrator.addColumn(books, books.publisher);
            await migrator.addColumn(books, books.publishedYear);
            await migrator.addColumn(books, books.coverUrl);
            await migrator.addColumn(books, books.inThreeSentences);
            await migrator.addColumn(books, books.impressions);
            await migrator.addColumn(books, books.whoShouldRead);
            await migrator.addColumn(books, books.howChangedMe);
            await migrator.addColumn(books, books.topThreeQuotes);
            await migrator.addColumn(books, books.tags);
          }
          if (from < 3) {
            await migrator.addColumn(books, books.isNonFiction);
          }
          if (from < 4) {
            await migrator.createTable(bookWidgets);
            await _migrateExistingNotesToWidgets();
          }
        },
      );

  Future<void> _migrateExistingNotesToWidgets() async {
    final existingBooks = await select(books).get();
    final now = DateTime.now().millisecondsSinceEpoch;

    await batch((batch) {
      for (final book in existingBooks) {
        final hasNotes = [
          book.note,
          book.inThreeSentences,
          book.impressions,
          book.whoShouldRead,
          book.howChangedMe,
          book.topThreeQuotes,
          book.tags,
        ].any((value) => value != null && value.isNotEmpty);

        if (!hasNotes) continue;

        batch.insert(
          bookWidgets,
          BookWidgetsCompanion.insert(
            bookId: book.id,
            type: 'notes',
            payloadJson: jsonEncode({
              'note': book.note,
              'inThreeSentences': _decodeJsonList(book.inThreeSentences),
              'impressions': book.impressions,
              'whoShouldRead': book.whoShouldRead,
              'howChangedMe': book.howChangedMe,
              'topThreeQuotes': _decodeJsonList(book.topThreeQuotes),
              'tags': _decodeJsonList(book.tags),
            }),
            sortOrder: 0,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    });
  }

  static List<String> _decodeJsonList(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>).cast<String>();
    } catch (_) {
      return [];
    }
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'bokorm');
  }
}
