import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveBook(Book newBook, UserBookEntry newUserBookEntry) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.books.putSync(newBook));
    isar.writeTxnSync<int>(() => isar.userBookEntrys.putSync(newUserBookEntry));
  }

  Future<void> saveBookNote(BookNotes newNote) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.bookNotes.putSync(newNote));
  }

  Future<void> saveFinalBookNote(FinishedBookNote finishedBookNote) async {
    final isar = await db;
    isar.writeTxnSync<int>(
        () => isar.finishedBookNotes.putSync(finishedBookNote));
  }

  Future<void> updateUserDataEntry(UserBookEntry newUserBookEntry) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.userBookEntrys.putSync(newUserBookEntry));
  }

  Future<void> updateBookSummary(Book book, String summary) async {
    final isar = await db;
    book.summary = summary;
    isar.writeTxnSync<int>(() => isar.books.putSync(book));
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

  Stream<List<Book>> getBooksOfStatus(List<BookStatus> statusList) async* {
    final isar = await db;

    // Query UserBookEntry based on status list
    final query = isar.userBookEntrys
        .where()
        .filter()
        .anyOf(statusList, (q, status) => q.statusEqualTo(status));

    await for (final userBookEntries in query.watch(fireImmediately: true)) {
      // If there are matching UserBookEntries, map them to Books
      if (userBookEntries.isNotEmpty) {
        final books = <Book>[];
        for (final entry in userBookEntries) {
          if (entry.bookReference.value != null) {
            books.add(entry.bookReference.value!);
          }
        }
        yield books;
      } else {
        yield [];
      }
    }
  }

  Future<List<BookNotes>> getAllBookNotes() async {
    final isar = await db;
    return isar.bookNotes.where(sort: Sort.asc).findAll();
  }

  Future<bool> deleteBook(Book bookToDelete) async {
    final isar = await db;

    // Load all necessary data outside the transaction
    final userBookEntry = bookToDelete.userDataReference.value;
    List<BookNotes> bookNotes = [];
    FinishedBookNote? finishedBookNote;

    if (userBookEntry != null) {
      bookNotes = await isar.bookNotes
          .filter()
          .bookReference((q) => q.idEqualTo(userBookEntry.id))
          .findAll();
      finishedBookNote = userBookEntry.finishedNote.value;
    }

    // Perform all deletions in a single transaction
    return await isar.writeTxn(() async {
      if (userBookEntry != null) {
        // Delete all associated BookNotes
        for (var note in bookNotes) {
          await isar.bookNotes.delete(note.noteId);
        }

        // Delete the FinishedBookNote if it exists
        if (finishedBookNote != null) {
          await isar.finishedBookNotes.delete(finishedBookNote.noteId);
        }

        // Delete the UserBookEntry
        await isar.userBookEntrys.delete(userBookEntry.id);
      }

      // Finally, delete the book
      return await isar.books.delete(bookToDelete.bookId);
    });
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        BookSchema,
        UserBookEntrySchema,
        BookNotesSchema,
        FinishedBookNoteSchema
      ], directory: dir.path, maxSizeMiB: 1024, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }
}
