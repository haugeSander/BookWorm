import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:flutter/material.dart';

Future<void> showDuplicateBookDialog({
  required BuildContext context,
  required Book book,
  required VoidCallback onViewBook,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(AppStrings.alreadyAdded),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(book.author),
          const SizedBox(height: 4),
          Text('Status: ${_statusLabel(book.status)}'),
          if (book.rating != null)
            Text('${'★' * book.rating!}${'☆' * (5 - book.rating!)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            onViewBook();
          },
          child: const Text(AppStrings.viewBook),
        ),
      ],
    ),
  );
}

String _statusLabel(String status) {
  switch (status) {
    case 'lest':
      return AppStrings.tabRead;
    case 'leser':
      return AppStrings.tabReading;
    case 'skalLese':
      return AppStrings.tabWantToRead;
    case 'droppet':
      return AppStrings.tabDropped;
    default:
      return status;
  }
}
