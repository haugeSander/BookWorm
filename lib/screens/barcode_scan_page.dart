import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/screens/book_detail.dart';
import 'package:book_worm/services/book_lookup_service.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/widgets/duplicate_book_dialog.dart';
import 'package:book_worm/widgets/status_picker_sheet.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class BarcodeScanPage extends StatefulWidget {
  const BarcodeScanPage({super.key});

  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  final _controller = MobileScannerController();
  final _lookup = BookLookupService();
  bool _processing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_processing) return;
    final barcode = capture.barcodes.firstOrNull;
    final isbn = barcode?.rawValue;
    if (isbn == null || isbn.isEmpty) return;

    setState(() => _processing = true);
    await _controller.stop();

    if (!mounted) return;
    final svc = context.read<DatabaseService>();

    // Check for duplicate by ISBN
    final existing = await svc.findByIsbn(isbn);
    if (!mounted) return;

    if (existing != null) {
      await showDuplicateBookDialog(
        context: context,
        book: existing,
        onViewBook: () => _openBook(context, existing, svc),
      );
      if (mounted) {
        setState(() => _processing = false);
        _controller.start();
      }
      return;
    }

    // Look up book via Open Library
    final result = await _lookup.fetchByIsbn(isbn);
    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.notFoundSnackbar)),
      );
      setState(() => _processing = false);
      _controller.start();
      return;
    }

    // Pick status and save
    final status = await showStatusPickerSheet(context);
    if (status == null || !mounted) {
      setState(() => _processing = false);
      _controller.start();
      return;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    await svc.saveBook(BooksCompanion(
      title: Value(result.title),
      author: Value(result.author),
      isbn: Value(isbn),
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

    if (mounted) Navigator.of(context).pop();
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
      appBar: AppBar(title: const Text(AppStrings.scanBarcode)),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),
          if (_processing) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
