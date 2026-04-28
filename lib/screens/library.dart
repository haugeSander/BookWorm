import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/screens/barcode_scan_page.dart';
import 'package:book_worm/screens/book_detail.dart';
import 'package:book_worm/screens/search_add_page.dart';
import 'package:book_worm/screens/user_and_settings.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:book_worm/widgets/book_cover_image.dart';
import 'package:book_worm/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final _searchController = TextEditingController();
  String _search = '';

  static const _tabs = [
    (null, AppStrings.tabAll),
    ('lest', AppStrings.tabRead),
    ('leser', AppStrings.tabReading),
    ('skalLese', AppStrings.tabWantToRead),
    ('droppet', AppStrings.tabDropped),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openBook(BuildContext context, Book book) {
    final svc = context.read<DatabaseService>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => BookDetailState(book: book, databaseService: svc),
          child: const BookDetailPage(),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Book book) async {
    final svc = context.read<DatabaseService>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(book.title),
        content: const Text(AppStrings.deleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              AppStrings.delete,
              style: TextStyle(color: AppTheme.statusDropped),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await svc.deleteBook(book.id);
    }
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text(AppStrings.scanBarcode),
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BarcodeScanPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text(AppStrings.searchForBook),
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchAddPage()),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/worm.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              const Text(AppStrings.appName),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              tooltip: AppStrings.settings,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserSettingsPage()),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                tabs: _tabs
                    .map((t) => Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(t.$2),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: AppStrings.searchHint,
                  prefixIcon: Icon(Icons.search, color: AppTheme.textSecondary),
                ),
                onChanged: (v) => setState(() => _search = v.trim()),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _tabs.map((t) {
                  return _BookList(
                    status: t.$1,
                    search: _search,
                    onTap: (b) => _openBook(context, b),
                    onLongPress: (b) => _confirmDelete(context, b),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddSheet(context),
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.addBook),
        ),
      ),
    );
  }
}

class _BookList extends StatelessWidget {
  final String? status;
  final String search;
  final void Function(Book) onTap;
  final void Function(Book) onLongPress;

  const _BookList({
    required this.status,
    required this.search,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final svc = context.read<DatabaseService>();
    return StreamBuilder<List<Book>>(
      stream: svc.watchAllBooks(search: search, status: status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final books = snapshot.data ?? [];
        if (books.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: 64,
                  color: AppTheme.textSecondary.withValues(alpha: 0.4),
                ),
                const SizedBox(height: 12),
                const Text(
                  AppStrings.noResults,
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 100),
          itemCount: books.length,
          itemBuilder: (_, i) => _BookCard(
            book: books[i],
            onTap: () => onTap(books[i]),
            onLongPress: () => onLongPress(books[i]),
          ),
        );
      },
    );
  }
}

class _BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _BookCard({
    required this.book,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Material(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _coverWidget(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppTheme.textPrimary,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        book.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          StatusBadge(status: book.status),
                          const Spacer(),
                          if (book.status == 'lest' && book.rating != null)
                            RatingBarIndicator(
                              rating: book.rating!.toDouble(),
                              itemCount: 5,
                              itemSize: 13,
                              itemBuilder: (_, __) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _coverWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BookCoverImage(
        coverImage: book.coverImage,
        coverUrl: book.coverUrl,
        width: 56,
        height: 76,
      ),
    );
  }
}
