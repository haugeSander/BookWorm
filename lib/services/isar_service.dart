import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/book_notes.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveBook(Book newBook) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.books.putSync(newBook));
  }

  Future<void> saveBookNote(BookNotes newNote) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.bookNotes.putSync(newNote));
  }

  Stream<List<Book>> getAllBooks({String? search}) async* {
    final isar = await db;
    final query = isar.books
        .where()
        .filter()
        .titleContains(search ?? '', caseSensitive: false);

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }

  Stream<List<Book>> getBooksOfStatus(BookStatus status) async* {
    final isar = await db;
    final query = isar.books.where().filter().statusEqualTo(status);

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([BookSchema, BookNotesSchema],
          directory: dir.path, maxSizeMiB: 1024, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }
}
