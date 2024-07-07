import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:isar/isar.dart';
import 'book_notes.dart';

part 'user_book_entry.g.dart';

enum BookStatus { finished, reading, listening, added, dropped }

@Collection()
class UserBookEntry {
  Id id = Isar.autoIncrement;

  @enumerated
  BookStatus status;

  DateTime? dateOfCurrentStatus;

  List<String> gallery;

  final bookNote = IsarLinks<BookNotes>();
  final finishedNote = IsarLink<FinishedBookNote>();

  @Backlink(to: 'userDataReference')
  final bookReference = IsarLink<Book>();

  UserBookEntry({
    required this.status,
    this.dateOfCurrentStatus,
    List<String> gallery = const [],
  }) : gallery = List<String>.from(gallery);
}
