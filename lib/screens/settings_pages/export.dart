import 'dart:io';

import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DataTransferPage extends StatelessWidget {
  const DataTransferPage({super.key});

  Future<void> _export(BuildContext context) async {
    final svc = context.read<DatabaseService>();
    try {
      final json = await svc.exportToJson();
      final dir = await getTemporaryDirectory();
      final fileName = 'bokorm_export_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = File('${dir.path}/$fileName');
      await file.writeAsString(json);
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: 'Bokorm dataeksport'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.exportSuccess)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppStrings.exportFailed}: $e')),
        );
      }
    }
  }

  Future<void> _import(BuildContext context) async {
    final svc = context.read<DatabaseService>();
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (result == null) return;
      final file = File(result.files.single.path!);
      final json = await file.readAsString();
      await svc.importFromJson(json);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.importSuccess)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppStrings.importFailed}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.dataTransfer)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.file_upload),
              label: const Text(AppStrings.export_),
              onPressed: () => _export(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.file_download),
              label: const Text(AppStrings.import_),
              onPressed: () => _import(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
