import 'package:book_worm/models/user_book_entry.dart';
import 'package:isar/isar.dart';

part 'finished_book_note.g.dart';

@Collection()
class FinishedBookNote {
  Id bookId;
  DateTime timeEnded;
  List<String> inThreeSentences;
  String impressions;
  String whoShouldRead;
  String howChangedMe;
  List<String> topThreeQuotes;
  List<String>? tags;
  int rating;

  @Backlink(to: "finishedNote")
  final bookDataReference = IsarLink<UserBookEntry>();

  FinishedBookNote({
    required this.bookId,
    required this.timeEnded,
    required this.inThreeSentences,
    required this.impressions,
    required this.whoShouldRead,
    required this.howChangedMe,
    required this.topThreeQuotes,
    List<String>? tags,
    required this.rating,
  }) : tags = tags ?? [];

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'timeEnded': timeEnded.toIso8601String(),
      'inThreeSentences': inThreeSentences,
      'impressions': impressions,
      'whoShouldRead': whoShouldRead,
      'howChangedMe': howChangedMe,
      'topThreeQuotes': topThreeQuotes,
      'tags': tags,
      'rating': rating,
      'bookDataReferenceId': bookDataReference.value?.bookId,
    };
  }
}
