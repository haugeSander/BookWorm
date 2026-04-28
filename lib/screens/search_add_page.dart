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
  final _manualTitleController = TextEditingController();
  final _manualAuthorController = TextEditingController();
  final _manualIsbnController = TextEditingController();
  final _manualPublisherController = TextEditingController();
  final _manualPublicationDateController = TextEditingController();
  final _manualCoverUrlController = TextEditingController();
  final _lookup = BookLookupService();
  Timer? _debounce;
  List<BookSearchResult> _results = [];
  bool _loading = false;
  bool _manualIsNonFiction = false;

  @override
  void dispose() {
    _controller.dispose();
    _manualTitleController.dispose();
    _manualAuthorController.dispose();
    _manualIsbnController.dispose();
    _manualPublisherController.dispose();
    _manualPublicationDateController.dispose();
    _manualCoverUrlController.dispose();
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

  Future<void> _openManualAddDialog() async {
    final query = _controller.text.trim();
    if (query.isNotEmpty && _manualTitleController.text.isEmpty) {
      _manualTitleController.text = query;
    }

    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            title: const Text(AppStrings.manualBookDetails),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ManualTextField(
                    controller: _manualTitleController,
                    label: AppStrings.title,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _ManualTextField(
                    controller: _manualAuthorController,
                    label: AppStrings.author,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _ManualTextField(
                    controller: _manualIsbnController,
                    label: AppStrings.isbn,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _ManualTextField(
                    controller: _manualPublisherController,
                    label: AppStrings.publisher,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _ManualTextField(
                    controller: _manualPublicationDateController,
                    label: AppStrings.publicationDate,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _ManualTextField(
                    controller: _manualCoverUrlController,
                    label: AppStrings.coverUrl,
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile.adaptive(
                    value: _manualIsNonFiction,
                    onChanged: (value) {
                      setDialogState(() => _manualIsNonFiction = value);
                    },
                    contentPadding: EdgeInsets.zero,
                    title: const Text(AppStrings.nonFiction),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text(AppStrings.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text(AppStrings.save),
              ),
            ],
          );
        },
      ),
    );

    if (shouldSave == true) {
      await _saveManualBook();
    }
  }

  Future<void> _saveManualBook() async {
    final title = _manualTitleController.text.trim();
    final author = _manualAuthorController.text.trim();
    if (title.isEmpty || author.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.requiredFieldsMissing)),
      );
      return;
    }

    final svc = context.read<DatabaseService>();
    final existing = await svc.findByTitleAuthor(title, author);
    if (!mounted) return;

    if (existing != null) {
      await showDuplicateBookDialog(
        context: context,
        book: existing,
        onViewBook: () => _openBook(context, existing, svc),
      );
      return;
    }

    final status = await showStatusPickerSheet(context);
    if (status == null || !mounted) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    await svc.saveBook(BooksCompanion(
      title: Value(title),
      author: Value(author),
      isbn: Value(_emptyToNull(_manualIsbnController.text)),
      status: Value(status),
      dateAdded: Value(now),
      dateStarted: status == 'leser' ? Value(now) : const Value(null),
      dateFinished: status == 'lest' ? Value(now) : const Value(null),
      coverUrl: Value(_emptyToNull(_manualCoverUrlController.text)),
      publisher: Value(_emptyToNull(_manualPublisherController.text)),
      publishedYear: Value(_emptyToNull(_manualPublicationDateController.text)),
      isNonFiction: Value(_manualIsNonFiction),
    ));

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
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
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openManualAddDialog,
                icon: const Icon(Icons.edit_note_outlined),
                label: const Text(AppStrings.addManually),
              ),
            ),
          ),
          Expanded(
            child: _results.isEmpty && !_loading && _controller.text.isNotEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        AppStrings.noSearchResults,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                    ),
                  )
                : ListView.builder(
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
                                  placeholder: (_, __) =>
                                      _thumbnailPlaceholder(),
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

class _ManualTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const _ManualTextField({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
