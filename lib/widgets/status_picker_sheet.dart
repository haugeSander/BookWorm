import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:flutter/material.dart';

const _statuses = [
  ('lest', AppStrings.statusLest),
  ('leser', AppStrings.statusLeser),
  ('skalLese', AppStrings.statusSkalLese),
  ('droppet', AppStrings.statusDroppet),
];

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

/// Shows a bottom sheet for picking a book status.
/// Returns the selected status string, or null if dismissed.
Future<String?> showStatusPickerSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.pickStatus,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ),
          ..._statuses.map((s) {
            final color = AppTheme.statusColor(s.$1);
            return InkWell(
              onTap: () => Navigator.of(ctx).pop(s.$1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_statusIcon(s.$1), color: color, size: 22),
                    ),
                    const SizedBox(width: 16),
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
          }),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
