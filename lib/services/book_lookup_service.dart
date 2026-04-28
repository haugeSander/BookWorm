import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BookSearchResult {
  final String title;
  final String author;
  final String? isbn;
  final String? coverUrl;
  final String? description;
  final int? pageCount;
  final String? publisher;
  final String? publishedYear;
  final bool isNonFiction;

  const BookSearchResult({
    required this.title,
    required this.author,
    this.isbn,
    this.coverUrl,
    this.description,
    this.pageCount,
    this.publisher,
    this.publishedYear,
    this.isNonFiction = false,
  });
}

class BookLookupService {
  static const _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static String get _apiKey => dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? '';

  Future<List<BookSearchResult>> searchBooks(String query) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'q': query,
      'maxResults': '15',
      'langRestrict': 'no',
      'key': _apiKey,
    });
    final response = await http.get(uri);
    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final items = (data['items'] as List<dynamic>?) ?? [];
    return items.map(_parseVolumeItem).whereType<BookSearchResult>().toList();
  }

  Future<BookSearchResult?> fetchByIsbn(String isbn) async {
    try {
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'q': 'isbn:$isbn',
        'key': _apiKey,
      });
      final response = await http.get(uri);
      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final items = (data['items'] as List<dynamic>?) ?? [];
      if (items.isEmpty) return null;
      return _parseVolumeItem(items.first);
    } catch (_) {
      return null;
    }
  }

  BookSearchResult? _parseVolumeItem(dynamic item) {
    final info =
        (item as Map<String, dynamic>)['volumeInfo'] as Map<String, dynamic>?;
    if (info == null) return null;

    final title = (info['title'] as String?) ?? '';
    if (title.isEmpty) return null;

    final authors = (info['authors'] as List<dynamic>?)?.cast<String>() ?? [];
    final author = authors.join(', ');

    // ISBN: prefer ISBN_13, fall back to ISBN_10
    String? isbn;
    final identifiers = (info['industryIdentifiers'] as List<dynamic>?) ?? [];
    for (final id in identifiers) {
      final m = id as Map<String, dynamic>;
      if (m['type'] == 'ISBN_13') {
        isbn = m['identifier'] as String?;
        break;
      }
    }
    if (isbn == null) {
      for (final id in identifiers) {
        final m = id as Map<String, dynamic>;
        if (m['type'] == 'ISBN_10') {
          isbn = m['identifier'] as String?;
          break;
        }
      }
    }

    // Cover: force https and request a larger size
    String? coverUrl;
    final imageLinks = info['imageLinks'] as Map<String, dynamic>?;
    if (imageLinks != null) {
      final thumb = (imageLinks['thumbnail'] as String?) ??
          (imageLinks['smallThumbnail'] as String?);
      coverUrl = thumb
          ?.replaceFirst('http://', 'https://')
          .replaceAll('zoom=1', 'zoom=2');
    }

    final pageCount = info['pageCount'] as int?;
    final publisher = info['publisher'] as String?;
    final publishedDate = info['publishedDate'] as String?;
    final publishedYear = (publishedDate != null && publishedDate.length >= 4)
        ? publishedDate.substring(0, 4)
        : publishedDate;
    final description = info['description'] as String?;
    final categories =
        (info['categories'] as List<dynamic>?)?.cast<String>() ?? [];

    return BookSearchResult(
      title: title,
      author: author,
      isbn: isbn,
      coverUrl: coverUrl,
      description: description,
      pageCount: pageCount,
      publisher: publisher,
      publishedYear: publishedYear,
      isNonFiction: _isNonFiction(categories),
    );
  }

  bool _isNonFiction(List<String> categories) {
    if (categories.isEmpty) return false;

    final normalized = categories.map((c) => c.toLowerCase()).join(' ');
    if (normalized.contains('nonfiction') ||
        normalized.contains('non-fiction') ||
        normalized.contains('faglitteratur')) {
      return true;
    }

    if (normalized.contains('fiction') ||
        normalized.contains('skjønnlitteratur')) {
      return false;
    }

    return true;
  }
}
