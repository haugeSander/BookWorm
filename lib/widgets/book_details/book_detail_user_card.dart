import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:book_worm/utility/book_taxonomy.dart';
import 'package:book_worm/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const _statuses = [
  ('lest', AppStrings.statusLest),
  ('leser', AppStrings.statusLeser),
  ('skalLese', AppStrings.statusSkalLese),
  ('droppet', AppStrings.statusDroppet),
];

class BookDetailUserCard extends StatelessWidget {
  const BookDetailUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
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
                  _buildStatusRow(context, state),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildBookType(state),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildDates(state),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildRating(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusRow(BuildContext context, BookDetailState state) {
    if (state.isEditMode) {
      return GestureDetector(
        onTap: () => _openStatusPicker(context, state),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusBadge(status: state.status),
            const SizedBox(width: 6),
            const Icon(Icons.edit, size: 14, color: AppTheme.textSecondary),
          ],
        ),
      );
    }
    return StatusBadge(status: state.status);
  }

  Widget _buildBookType(BookDetailState state) {
    final typeLabel = bookTypeLabel(state.isNonFiction);
    final genreOptions = genreOptionsFor(state.isNonFiction);
    final selectedGenre =
        genreOptions.any((option) => option.value == state.genre)
            ? state.genre
            : null;
    final selectedGenreLabel = genreLabel(state.genre);

    if (state.isEditMode) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FieldTitle(
            icon: Icons.category_outlined,
            label: AppStrings.bookType,
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<bool>(
            initialValue: state.isNonFiction,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.category_outlined, size: 18),
            ),
            items: const [
              DropdownMenuItem(
                value: false,
                child: Text(AppStrings.fiction),
              ),
              DropdownMenuItem(
                value: true,
                child: Text(AppStrings.nonFiction),
              ),
            ],
            onChanged: (value) {
              if (value != null) state.updateIsNonFiction(value);
            },
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
            dropdownColor: AppTheme.surface,
            iconEnabledColor: AppTheme.primary,
            isExpanded: true,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 12),
          const _FieldTitle(
            icon: Icons.local_offer_outlined,
            label: AppStrings.genre,
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: selectedGenre,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.local_offer_outlined, size: 18),
            ),
            hint: const Text(AppStrings.genre),
            items: genreOptions
                .map(
                  (option) => DropdownMenuItem(
                    value: option.value,
                    child: Text(option.label, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: state.updateGenre,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
            dropdownColor: AppTheme.surface,
            iconEnabledColor: AppTheme.primary,
            isExpanded: true,
            borderRadius: BorderRadius.circular(12),
            menuMaxHeight: 320,
          ),
        ],
      );
    }

    return Column(
      children: [
        _DateRow(
          icon: Icons.category_outlined,
          label: AppStrings.bookType,
          date: typeLabel,
        ),
        if (selectedGenreLabel != null) ...[
          const SizedBox(height: 8),
          _DateRow(
            icon: Icons.local_offer_outlined,
            label: AppStrings.genre,
            date: selectedGenreLabel,
          ),
        ],
      ],
    );
  }

  Widget _buildDates(BookDetailState state) {
    final fmt = DateFormat('d. MMM y');
    final dateAdded = DateTime.fromMillisecondsSinceEpoch(state.book.dateAdded);
    final dateStarted = state.book.dateStarted != null
        ? DateTime.fromMillisecondsSinceEpoch(state.book.dateStarted!)
        : null;
    final dateFinished = state.book.dateFinished != null
        ? DateTime.fromMillisecondsSinceEpoch(state.book.dateFinished!)
        : null;

    return Column(
      children: [
        _DateRow(
          icon: Icons.calendar_today_outlined,
          label: AppStrings.dateAdded,
          date: fmt.format(dateAdded),
        ),
        if (dateStarted != null) ...[
          const SizedBox(height: 8),
          _DateRow(
            icon: Icons.play_circle_outline,
            label: AppStrings.dateStarted,
            date: fmt.format(dateStarted),
          ),
        ],
        if (dateFinished != null) ...[
          const SizedBox(height: 8),
          _DateRow(
            icon: Icons.check_circle_outline,
            label: AppStrings.dateFinished,
            date: fmt.format(dateFinished),
          ),
        ],
      ],
    );
  }

  Widget _buildRating(BookDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.rating,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        RatingBar(
          minRating: 1,
          maxRating: 5,
          initialRating: (state.rating ?? 0).toDouble(),
          ignoreGestures: !state.isEditMode,
          ratingWidget: RatingWidget(
            full: const Icon(Icons.star, color: Colors.amber),
            half: const Icon(Icons.star_half, color: Colors.amber),
            empty: Icon(
              Icons.star_border,
              color: AppTheme.textSecondary.withValues(alpha: 0.3),
            ),
          ),
          allowHalfRating: false,
          itemSize: 28,
          onRatingUpdate: (r) => state.updateRating(r.toInt()),
        ),
      ],
    );
  }

  void _openStatusPicker(BuildContext context, BookDetailState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.pickStatus),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _statuses.map((s) {
            final color = AppTheme.statusColor(s.$1);
            return InkWell(
              onTap: () {
                state.updateStatus(s.$1);
                Navigator.of(ctx).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_statusIcon(s.$1), color: color, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      s.$2,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'lest':
        return Icons.check_circle_outline;
      case 'leser':
        return Icons.menu_book_outlined;
      case 'skalLese':
        return Icons.bookmark_outline;
      case 'droppet':
        return Icons.remove_circle_outline;
      default:
        return Icons.help_outline;
    }
  }
}

class _DateRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String date;

  const _DateRow({required this.icon, required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppTheme.textSecondary),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
        ),
        const Spacer(),
        Text(
          date,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _FieldTitle extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FieldTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppTheme.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
