import 'package:book_worm/utility/app_strings.dart';

class BookGenreOption {
  final String value;
  final String label;

  const BookGenreOption(this.value, this.label);
}

const fictionGenres = [
  BookGenreOption('literary', 'Litterær roman'),
  BookGenreOption('drama', 'Drama'),
  BookGenreOption('action', 'Action'),
  BookGenreOption('romance', 'Romantikk'),
  BookGenreOption('sciFi', 'Sci-fi'),
  BookGenreOption('fantasy', 'Fantasy'),
  BookGenreOption('crime', 'Krim'),
  BookGenreOption('thriller', 'Thriller'),
  BookGenreOption('horror', 'Skrekk'),
  BookGenreOption('historical', 'Historisk roman'),
  BookGenreOption('youngAdult', 'Ungdom'),
  BookGenreOption('shortStories', 'Noveller'),
  BookGenreOption('other', 'Annet'),
];

const nonFictionGenres = [
  BookGenreOption('selfHelp', 'Selvutvikling'),
  BookGenreOption('psychology', 'Psykologi'),
  BookGenreOption('biography', 'Biografi'),
  BookGenreOption('science', 'Vitenskap'),
  BookGenreOption('philosophy', 'Filosofi'),
  BookGenreOption('journal', 'Journal / essay'),
  BookGenreOption('history', 'Historie'),
  BookGenreOption('business', 'Business'),
  BookGenreOption('health', 'Helse'),
  BookGenreOption('other', 'Annet'),
];

List<BookGenreOption> genreOptionsFor(bool isNonFiction) {
  return isNonFiction ? nonFictionGenres : fictionGenres;
}

String bookTypeLabel(bool isNonFiction) {
  return isNonFiction ? AppStrings.nonFiction : AppStrings.fiction;
}

String? genreLabel(String? value) {
  if (value == null || value.isEmpty) return null;
  for (final option in [...fictionGenres, ...nonFictionGenres]) {
    if (option.value == value) return option.label;
  }
  return value;
}
