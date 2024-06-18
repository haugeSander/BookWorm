import 'package:book_worm/models/book.dart';
import 'package:isar/isar.dart';

part 'book_notes.g.dart';

@Collection()
class BookNotes {
  Id noteId = Isar.autoIncrement;
  int? rating;
  DateTime? timeStarted;
  DateTime? timeEnded;
  bool? isReadingNow;
  bool? asAudioBook;
  String? inThreeSentences;
  String? impressions;
  String? whoShouldRead;
  String? howChangedMe;
  String? topThreeQuotes;
  String? summary;

  @Backlink(to: "bookNote")
  final bookReference = IsarLink<Book>();
}
