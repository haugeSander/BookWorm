import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:book_worm/models/user.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:isar/isar.dart';
import 'dart:convert';
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

  Future<void> updateBookEntry(Book book) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.books.putSync(book));
  }

  Future<void> updateUserDataEntry(UserBookEntry newUserBookEntry) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Update UserBookEntry
      await isar.userBookEntrys.put(newUserBookEntry);

      // Update FinishedBookNote if it exists
      if (newUserBookEntry.finishedNote.value != null) {
        await isar.finishedBookNotes.put(newUserBookEntry.finishedNote.value!);
      }
    });
  }

  Future<void> updateBookSummary(Book book, String summary) async {
    final isar = await db;
    book.summary = summary;
    isar.writeTxnSync<int>(() => isar.books.putSync(book));
  }

  Future<void> updateBookNote(BookNotes note) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.bookNotes.put(note);
    });
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

  Future<List<UserBookEntry>> getAllUserData() async {
    final isar = await db;
    return await isar.userBookEntrys.where(sort: Sort.asc).findAll();
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

  Future<Map<String, dynamic>> getStatistics() async {
    final isar = await db;

    final allEntries = await isar.userBookEntrys.where().findAll();

    int totalBooks = allEntries.length;
    int booksInProgress = 0;
    int finishedBooks = 0;
    double totalRating = 0;

    for (var entry in allEntries) {
      if (entry.status == BookStatus.finished) {
        finishedBooks++;
        if (entry.finishedNote.value != null) {
          totalRating += entry.finishedNote.value!.rating;
        }
      } else if (entry.status == BookStatus.reading ||
          entry.status == BookStatus.listening) {
        booksInProgress++;
      }
    }

    double averageRating = finishedBooks > 0 ? totalRating / finishedBooks : 0;

    return {
      'totalBooks': totalBooks,
      'booksInProgress': booksInProgress,
      'finishedBooks': finishedBooks,
      'averageRating': averageRating,
    };
  }

  Future<List<BookNotes>> getAllBookNotes() async {
    final isar = await db;
    return isar.bookNotes.where(sort: Sort.asc).findAll();
  }

  Future<bool> deleteNote(BookNotes? noteToRemove) async {
    if (noteToRemove != null) {
      final isar = await db;
      return await isar.writeTxn(() async {
        // Load the associated UserBookEntry
        await noteToRemove.bookReference.load();
        final userBookEntry = noteToRemove.bookReference.value;
        if (userBookEntry == null) return false;

        // Delete the note
        bool deleted = await isar.bookNotes.delete(noteToRemove.noteId);
        if (!deleted) return false;

        // Reindex the remaining notes
        await userBookEntry.bookNote.load();
        final remainingNotes = userBookEntry.bookNote.toList();
        remainingNotes.sort((a, b) => a.timeOfNote.compareTo(b.timeOfNote));

        for (int i = 0; i < remainingNotes.length; i++) {
          remainingNotes[i].noteNumber = i + 1;
          await isar.bookNotes.put(remainingNotes[i]);
        }

        return true;
      });
    }
    return false;
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
          .bookReference((q) => q.bookIdEqualTo(userBookEntry.bookId))
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
          await isar.finishedBookNotes.delete(finishedBookNote.bookId);
        }

        // Delete the UserBookEntry
        await isar.userBookEntrys.delete(userBookEntry.bookId);
      }

      // Finally, delete the book
      return await isar.books.delete(bookToDelete.bookId);
    });
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<User?> getUser() async {
    final isar = await db;
    return isar.users.get(1);
  }

  Future<Book?> getBook(Id bookId) async {
    final isar = await db;
    return isar.books.get(bookId);
  }

  Future<void> updateUser(User updatedUser) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final existingUser = await isar.users.get(0);
      if (existingUser != null) {
        existingUser
          ..username = updatedUser.username
          ..firstName = updatedUser.firstName
          ..lastName = updatedUser.lastName
          ..biography = updatedUser.biography;
        if (existingUser.profileImage != null) {
          existingUser.profileImage = updatedUser.profileImage;
        }
        await isar.users.put(existingUser);
      } else {
        await isar.users.put(updatedUser);
      }
    });
  }

  Future<String> exportToJson(List<String> selectedCollections) async {
    Map<String, dynamic> exportData = {};

    final isar = await db;

    if (selectedCollections.contains('BookNotes')) {
      final bookNotes = await isar.bookNotes.where().findAll();
      exportData['BookNotes'] = bookNotes.map((note) => note.toJson()).toList();
    }

    if (selectedCollections.contains('Book')) {
      final books = await isar.books.where().findAll();
      exportData['Book'] = books.map((book) => book.toJson()).toList();
    }

    if (selectedCollections.contains('FinishedBookNote')) {
      final finishedNotes = await isar.finishedBookNotes.where().findAll();
      exportData['FinishedBookNote'] =
          finishedNotes.map((note) => note.toJson()).toList();
    }

    if (selectedCollections.contains('UserBookEntry')) {
      final userEntries = await isar.userBookEntrys.where().findAll();
      exportData['UserBookEntry'] =
          userEntries.map((entry) => entry.toJson()).toList();
    }

    if (selectedCollections.contains('User')) {
      final users = await isar.users.where().findAll();
      exportData['User'] = users.map((user) => user.toJson()).toList();
    }

    return jsonEncode(exportData);
  }

  Future<void> importFromJson(String jsonString) async {
    final Map<String, dynamic> importData = jsonDecode(jsonString);

    final isar = await db;

    await isar.writeTxn(() async {
      // Import BookNotes
      if (importData.containsKey('BookNotes')) {
        for (var noteData in importData['BookNotes']) {
          final note = BookNotes(
            timeOfNote: DateTime.parse(noteData['timeOfNote']),
            noteContent: noteData['noteContent'],
            noteNumber: noteData['noteNumber'],
            statusWhenNoted: BookStatus.values[noteData['statusWhenNoted']],
          )..noteId = noteData['noteId'];
          await isar.bookNotes.put(note);
        }
      }

      // Import Books
      if (importData.containsKey('Book')) {
        for (var bookData in importData['Book']) {
          final book = Book(
            title: bookData['title'],
            author: bookData['author'],
            coverImage: bookData['coverImage'],
            summary: bookData['summary'],
          )..bookId = bookData['bookId'];
          await isar.books.put(book);
        }
      }

      // Import FinishedBookNotes
      if (importData.containsKey('FinishedBookNote')) {
        for (var noteData in importData['FinishedBookNote']) {
          final note = FinishedBookNote(
            bookId: noteData['bookId'],
            timeEnded: DateTime.parse(noteData['timeEnded']),
            inThreeSentences: List<String>.from(noteData['inThreeSentences']),
            impressions: noteData['impressions'],
            whoShouldRead: noteData['whoShouldRead'],
            howChangedMe: noteData['howChangedMe'],
            topThreeQuotes: List<String>.from(noteData['topThreeQuotes']),
            tags: noteData['tags'] != null
                ? List<String>.from(noteData['tags'])
                : null,
            rating: noteData['rating'],
          );
          await isar.finishedBookNotes.put(note);
        }
      }

      // Import UserBookEntries
      if (importData.containsKey('UserBookEntry')) {
        for (var entryData in importData['UserBookEntry']) {
          final entry = UserBookEntry(
            bookId: entryData['bookId'],
            status: BookStatus.values[entryData['status']],
            dateOfCurrentStatus: entryData['dateOfCurrentStatus'] != null
                ? DateTime.parse(entryData['dateOfCurrentStatus'])
                : null,
            gallery: List<String>.from(entryData['gallery']),
          )..timeStarted = entryData['timeStarted'] != null
              ? DateTime.parse(entryData['timeStarted'])
              : null;
          await isar.userBookEntrys.put(entry);
        }
      }

      // Import Users
      if (importData.containsKey('User')) {
        for (var userData in importData['User']) {
          final user = User(
            username: userData['username'],
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            biography: userData['biography'],
            profileImage: userData['profileImage'],
          )
            ..userId = userData['userId']
            ..readingGoal = userData['readingGoal']
            ..achieveBy = DateTime.parse(userData['achieveBy']);
          await isar.users.put(user);
        }
      }
    });

    // Establish links after all objects are created
    await isar.writeTxn(() async {
      if (importData.containsKey('BookNotes')) {
        for (var noteData in importData['BookNotes']) {
          if (noteData['bookReferenceId'] != null) {
            final note = await isar.bookNotes.get(noteData['noteId']);
            final book =
                await isar.userBookEntrys.get(noteData['bookReferenceId']);
            if (note != null && book != null) {
              note.bookReference.value = book;
              await isar.bookNotes.put(note);
            }
          }
        }
      }

      if (importData.containsKey('UserBookEntry')) {
        for (var entryData in importData['UserBookEntry']) {
          final entry = await isar.userBookEntrys.get(entryData['bookId']);
          if (entry != null) {
            if (entryData['bookNoteIds'] != null) {
              for (var noteId in entryData['bookNoteIds']) {
                final note = await isar.bookNotes.get(noteId);
                if (note != null) {
                  entry.bookNote.add(note);
                }
              }
            }
            if (entryData['finishedNoteId'] != null) {
              final finishedNote =
                  await isar.finishedBookNotes.get(entryData['finishedNoteId']);
              if (finishedNote != null) {
                entry.finishedNote.value = finishedNote;
              }
            }
            if (entryData['bookReferenceId'] != null) {
              final book = await isar.books.get(entryData['bookReferenceId']);
              if (book != null) {
                entry.bookReference.value = book;
              }
            }
            await isar.userBookEntrys.put(entry);
          }
        }
      }
    });
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        BookSchema,
        UserBookEntrySchema,
        BookNotesSchema,
        FinishedBookNoteSchema,
        UserSchema
      ], directory: dir.path, maxSizeMiB: 1024, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }
}
