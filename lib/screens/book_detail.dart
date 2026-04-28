import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:book_worm/widgets/book_details/book_detail_header.dart';
import 'package:book_worm/widgets/book_details/book_detail_nonfiction_card.dart';
import 'package:book_worm/widgets/book_details/book_detail_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _notesEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadNotesEnabled();
  }

  Future<void> _loadNotesEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() => _notesEnabled = prefs.getBool('notesEnabled') ?? false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
        return Scaffold(
          extendBodyBehindAppBar: !state.isEditMode,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: state.isEditMode
                ? AppTheme.surface
                : Colors.transparent,
            elevation: state.isEditMode ? null : 0,
            scrolledUnderElevation: state.isEditMode ? null : 0,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: state.isEditMode
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            title: state.isEditMode
                ? const Text(AppStrings.editBook)
                : null,
            actions: [
              if (state.isEditMode) ...[
                TextButton(
                  onPressed: state.discardChanges,
                  child: const Text(AppStrings.cancel),
                ),
                TextButton(
                  onPressed: () async {
                    await state.saveChanges();
                  },
                  child: const Text(AppStrings.save),
                ),
              ] else
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                  onPressed: state.toggleEditMode,
                ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: BookDetailHeader()),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
                sliver: SliverToBoxAdapter(child: BookDetailUserCard()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                sliver: SliverToBoxAdapter(
                  child: _notesEnabled && state.isNonFiction
                      ? BookDetailNonFictionCard(state: state)
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NoteField extends StatefulWidget {
  final BookDetailState state;

  const _NoteField({required this.state});

  @override
  State<_NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<_NoteField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.state.note ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.note,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ctrl,
              enabled: widget.state.isEditMode,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: AppStrings.notesHint,
                border: InputBorder.none,
                filled: false,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                height: 1.5,
              ),
              onChanged: widget.state.updateNote,
            ),
          ],
        ),
      ),
    );
  }
}
