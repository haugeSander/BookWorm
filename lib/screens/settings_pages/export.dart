import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:share_plus/share_plus.dart';

class DataTransferPage extends StatefulWidget {
  const DataTransferPage({super.key});

  @override
  _DataTransferPageState createState() => _DataTransferPageState();
}

class _DataTransferPageState extends State<DataTransferPage> {
  final List<String> collections = [
    'BookNotes',
    'Book',
    'FinishedBookNote',
    'UserBookEntry',
    'User'
  ];
  List<String> selectedCollections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Transfer', style: TextStyle()),
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select collections to export/import:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 4,
                child: ListView(
                  children: collections.map((collection) {
                    return CheckboxListTile(
                      title: Text(collection),
                      value: selectedCollections.contains(collection),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedCollections.add(collection);
                          } else {
                            selectedCollections.remove(collection);
                          }
                        });
                      },
                      activeColor: Theme.of(context).primaryColor,
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.file_upload,
                color: Colors.white,
              ),
              label: const Text('Export Selected',
                  style: TextStyle(color: Colors.white)),
              onPressed: () => _exportSelected(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.file_download,
                color: Colors.white,
              ),
              label: const Text(
                'Import Data',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _importData(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportSelected(BuildContext context) async {
    if (selectedCollections.isEmpty) {
      _showSnackBar('Please select at least one collection to export.');
      return;
    }

    try {
      String jsonData = await IsarService().exportToJson(selectedCollections);

      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      final fileName = 'export_${DateTime.now().millisecondsSinceEpoch}.json';
      final filePath = '${directory.path}/$fileName';

      // Write the file
      final file = File(filePath);
      await file.writeAsString(jsonData);

      // Create XFile
      final xFile = XFile(filePath);

      // Share the file
      await Share.shareXFiles([xFile], text: 'Here\'s your exported data');

      _showSnackBar('Export completed successfully!');
    } catch (e) {
      _showSnackBar('Export failed: ${e.toString()}');
    }
  }

  Future<void> _importData(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String jsonString = await file.readAsString();

        await IsarService().importFromJson(jsonString);

        _showSnackBar('Import completed successfully!');
      }
    } catch (e) {
      _showSnackBar('Import failed: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
