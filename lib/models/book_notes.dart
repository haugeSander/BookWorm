import 'package:book_worm/models/user_book_entry.dart';
import 'package:isar/isar.dart';

part 'book_notes.g.dart';

@Collection()
class BookNotes {
  Id noteId = Isar.autoIncrement;
  DateTime timeOfNote;
  String noteContent;
  int noteNumber;
  @enumerated
  BookStatus statusWhenNoted;

  @Backlink(to: 'bookNote')
  final bookReference = IsarLink<UserBookEntry>();

  BookNotes({
    required this.timeOfNote,
    required this.noteContent,
    required this.noteNumber,
    required this.statusWhenNoted,
  });
}
