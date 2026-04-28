import 'dart:convert';

import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:book_worm/widgets/image_picker.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookDetailState extends ChangeNotifier {
  Book book;
  final DatabaseService databaseService;
  bool isEditMode = false;

  // Mutable copies of editable fields
  late String _title;
  late String _author;
  late String _status;
  int? _rating;
  String? _note;
  String _coverImage;
  bool _isNonFiction;

  // Structured non-fiction note fields
  late List<String> _inThreeSentences;
  String? _impressions;
  String? _whoShouldRead;
  String? _howChangedMe;
  late List<String> _topThreeQuotes;
  late List<String> _tags;

  BookDetailState({required this.book, required this.databaseService})
      : _title = book.title,
        _author = book.author,
        _status = book.status,
        _rating = book.rating,
        _note = book.note,
        _coverImage = book.coverImage,
        _isNonFiction = book.isNonFiction,
        _inThreeSentences = _decodeJsonList(book.inThreeSentences),
        _impressions = book.impressions,
        _whoShouldRead = book.whoShouldRead,
        _howChangedMe = book.howChangedMe,
        _topThreeQuotes = _decodeJsonList(book.topThreeQuotes),
        _tags = _decodeJsonList(book.tags);

  static List<String> _decodeJsonList(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>).cast<String>();
    } catch (_) {
      return [];
    }
  }

  static String _encodeJsonList(List<String> list) => jsonEncode(list);

  // Getters
  String get title => _title;
  String get author => _author;
  String get status => _status;
  int? get rating => _rating;
  String? get note => _note;
  String get coverImage => _coverImage;
  bool get isNonFiction => _isNonFiction;
  List<String> get inThreeSentences => _inThreeSentences;
  String? get impressions => _impressions;
  String? get whoShouldRead => _whoShouldRead;
  String? get howChangedMe => _howChangedMe;
  List<String> get topThreeQuotes => _topThreeQuotes;
  List<String> get tags => _tags;

  void toggleEditMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  void discardChanges() {
    _title = book.title;
    _author = book.author;
    _status = book.status;
    _rating = book.rating;
    _note = book.note;
    _coverImage = book.coverImage;
    _isNonFiction = book.isNonFiction;
    _inThreeSentences = _decodeJsonList(book.inThreeSentences);
    _impressions = book.impressions;
    _whoShouldRead = book.whoShouldRead;
    _howChangedMe = book.howChangedMe;
    _topThreeQuotes = _decodeJsonList(book.topThreeQuotes);
    _tags = _decodeJsonList(book.tags);
    isEditMode = false;
    notifyListeners();
  }

  Future<void> saveChanges() async {
    final updated = book.copyWith(
      title: _title,
      author: _author,
      status: _status,
      rating: Value(_rating),
      note: Value(_note),
      coverImage: _coverImage,
      isNonFiction: _isNonFiction,
      dateStarted: _status == 'leser' && book.dateStarted == null
          ? Value(DateTime.now().millisecondsSinceEpoch)
          : Value(book.dateStarted),
      dateFinished: _status == 'lest' && book.dateFinished == null
          ? Value(DateTime.now().millisecondsSinceEpoch)
          : Value(book.dateFinished),
      inThreeSentences: Value(_inThreeSentences.isEmpty
          ? null
          : _encodeJsonList(_inThreeSentences)),
      impressions: Value(_impressions),
      whoShouldRead: Value(_whoShouldRead),
      howChangedMe: Value(_howChangedMe),
      topThreeQuotes: Value(
          _topThreeQuotes.isEmpty ? null : _encodeJsonList(_topThreeQuotes)),
      tags: Value(_tags.isEmpty ? null : _encodeJsonList(_tags)),
    );
    await databaseService.updateBook(updated);
    book = updated;
    isEditMode = false;
    notifyListeners();
  }

  void updateTitle(String v) {
    _title = v;
    notifyListeners();
  }

  void updateAuthor(String v) {
    _author = v;
    notifyListeners();
  }

  void updateStatus(String v) {
    _status = v;
    notifyListeners();
  }

  void updateRating(int v) {
    _rating = v;
    notifyListeners();
  }

  void updateNote(String v) {
    _note = v.isEmpty ? null : v;
    notifyListeners();
  }

  void updateIsNonFiction(bool v) {
    _isNonFiction = v;
    notifyListeners();
  }

  void updateInThreeSentences(int index, String v) {
    while (_inThreeSentences.length <= index) {
      _inThreeSentences.add('');
    }
    _inThreeSentences[index] = v;
    notifyListeners();
  }

  void updateImpressions(String v) {
    _impressions = v.isEmpty ? null : v;
    notifyListeners();
  }

  void updateWhoShouldRead(String v) {
    _whoShouldRead = v.isEmpty ? null : v;
    notifyListeners();
  }

  void updateHowChangedMe(String v) {
    _howChangedMe = v.isEmpty ? null : v;
    notifyListeners();
  }

  void updateTopThreeQuotes(int index, String v) {
    while (_topThreeQuotes.length <= index) {
      _topThreeQuotes.add('');
    }
    _topThreeQuotes[index] = v;
    notifyListeners();
  }

  void addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      _tags = List.from(_tags)..add(tag);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    _tags = List.from(_tags)..remove(tag);
    notifyListeners();
  }

  void updateCoverImage(BuildContext context) {
    ImagePickerHelper(onImagePicked: (file) async {
      try {
        final dir = await getApplicationDocumentsDirectory();
        final fileName =
            '${book.title}-${DateTime.now().millisecondsSinceEpoch}.jpg';
        final newImage = await file.copy('${dir.path}/$fileName');
        _coverImage = newImage.path;
        notifyListeners();
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Klarte ikke lagre bilde: $e')),
        );
      }
    }).showImagePickerOptions(context);
  }

  Color statusColor() => AppTheme.statusColor(_status);

  void navigateBack(BuildContext context) {
    isEditMode = false;
    Navigator.pop(context);
  }
}
