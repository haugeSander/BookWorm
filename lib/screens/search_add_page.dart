import 'dart:async';

import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/screens/book_detail.dart';
import 'package:book_worm/services/book_lookup_service.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:book_worm/widgets/duplicate_book_dialog.dart';
import 'package:book_worm/widgets/status_picker_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchAddPage extends StatefulWidget {
  const SearchAddPage({super.key});

  @override
  State<SearchAddPage> createState() => _SearchAddPageState();
}

class _SearchAddPageState extends State<SearchAddPage> {
  final _controller = TextEditingController();
  final _lookup = BookLookupService();
  Timer? _debounce;
  List<BookSearchResult> _results = [];
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    if (value.trim().isEmpty) {
      setState(() => _results = []);
      return;
    }
    _debounce =
        Timer(const Duration(milliseconds: 300), () => _search(value.trim()));
  }

  Widget _thumbnailPlaceholder() => Container(
        width: 40,
        height: 54,
        color: AppTheme.surfaceVariant,
        child: const Icon(Icons.menu_book,
            color: AppTheme.textSecondary, size: 20),
      );

  Future<void> _search(String query) async {
    setState(() => _loading = true);
    final results = await _lookup.searchBooks(query);
    if (mounted) {
      setState(() {
        _results = results;
        _loading = false;
      });
    }
  }

  Future<void> _onResultTap(
      BuildContext context, BookSearchResult result) async {
    final svc = context.read<DatabaseService>();
    final existing = await svc.findByTitleAuthor(result.title, result.author);

    if (!mounted) return;

    if (existing != null) {
      await showDuplicateBookDialog(
        // ignore: use_build_context_synchronously
        context: context,
        book: existing,
        onViewBook: () => _openBook(context, existing, svc),
      );
      return;
    }

    // ignore: use_build_context_synchronously
    final status = await showStatusPickerSheet(context);
    if (status == null || !mounted) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    await svc.saveBook(BooksCompanion(
      title: Value(result.title),
      author: Value(result.author),
      isbn: Value(result.isbn),
      status: Value(status),
      dateAdded: Value(now),
      dateStarted: status == 'leser' ? Value(now) : const Value(null),
      dateFinished: status == 'lest' ? Value(now) : const Value(null),
      coverUrl: Value(result.coverUrl),
      description: Value(result.description),
      pageCount: Value(result.pageCount),
      publisher: Value(result.publisher),
      publishedYear: Value(result.publishedYear),
      isNonFiction: Value(result.isNonFiction),
    ));

    if (mounted) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  void _openBook(BuildContext context, Book book, DatabaseService svc) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => BookDetailState(book: book, databaseService: svc),
          child: const BookDetailPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.searchForBook)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: AppStrings.searchPlaceholder,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onChanged,
            ),
          ),
          if (_loading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (_, i) {
                final r = _results[i];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: r.coverUrl != null
                        ? CachedNetworkImage(
                            imageUrl: r.coverUrl!,
                            width: 40,
                            height: 54,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => _thumbnailPlaceholder(),
                            errorWidget: (_, __, ___) =>
                                _thumbnailPlaceholder(),
                          )
                        : _thumbnailPlaceholder(),
                  ),
                  title: Text(r.title,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  subtitle: Text(r.author,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: () => _onResultTap(context, r),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
