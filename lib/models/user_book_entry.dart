import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:isar/isar.dart';
import 'book_notes.dart';

part 'user_book_entry.g.dart';

enum BookStatus { finished, reading, listening, added, dropped }

@Collection()
class UserBookEntry {
  Id bookId;

  @enumerated
  BookStatus status;

  DateTime? timeStarted;
  DateTime? dateOfCurrentStatus;

  List<String> gallery;

  var bookNote = IsarLinks<BookNotes>();
  var finishedNote = IsarLink<FinishedBookNote>();

  @Backlink(to: 'userDataReference')
  final bookReference = IsarLink<Book>();

  UserBookEntry({
    required this.bookId,
    required this.status,
    this.dateOfCurrentStatus,
    List<String> gallery = const [],
  }) : gallery = List<String>.from(gallery);

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'status': status.index,
      'timeStarted': timeStarted?.toIso8601String(),
      'dateOfCurrentStatus': dateOfCurrentStatus?.toIso8601String(),
      'gallery': gallery,
      'bookNoteIds': bookNote.map((note) => note.noteId).toList(),
      'finishedNoteId': finishedNote.value?.bookId,
      'bookReferenceId': bookReference.value?.bookId,
    };
  }
}
