import 'package:isar/isar.dart';
import 'package:book_worm/models/book.dart';

part 'finished_book_note.g.dart';

@Collection()
class FinishedBookNote {
  Id noteId = Isar.autoIncrement;
  DateTime timeEnded;
  String inThreeSentences;
  String impressions;
  String whoShouldRead;
  String howChangedMe;
  String topThreeQuotes;
  String summary;
  int rating;

  @Backlink(to: "bookNote")
  final bookReference = IsarLink<Book>();

  FinishedBookNote({
    required this.noteId,
    required this.timeEnded,
    required this.inThreeSentences,
    required this.impressions,
    required this.whoShouldRead,
    required this.howChangedMe,
    required this.topThreeQuotes,
    required this.summary,
    required this.rating,
  });
}
