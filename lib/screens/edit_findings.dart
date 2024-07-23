import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:flutter/material.dart';

class EditFindingsPage extends StatefulWidget {
  final Book book;
  final FinishedBookNote finalNote;
  final Function(FinishedBookNote) onSave;

  const EditFindingsPage({
    super.key,
    required this.book,
    required this.finalNote,
    required this.onSave,
  });

  @override
  _EditFindingsPageState createState() => _EditFindingsPageState();
}

class _EditFindingsPageState extends State<EditFindingsPage> {
  late FinishedBookNote _editedNote;

  @override
  void initState() {
    super.initState();
    _editedNote = FinishedBookNote(
        bookId: widget.book.bookId,
        timeEnded: widget.finalNote.timeEnded,
        rating: widget.finalNote.rating,
        inThreeSentences: List.from(widget.finalNote.inThreeSentences),
        impressions: widget.finalNote.impressions,
        whoShouldRead: widget.finalNote.whoShouldRead,
        topThreeQuotes: List.from(widget.finalNote.topThreeQuotes),
        tags: List.from(widget.finalNote.tags),
        howChangedMe: widget.finalNote.howChangedMe);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editing your findings for ${widget.book.title}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEditableCard(
                'The Book in 3 Sentences',
                _editedNote.inThreeSentences,
                (newValue) =>
                    setState(() => _editedNote.inThreeSentences = newValue),
              ),
              _buildEditableCard(
                'Impressions',
                [_editedNote.impressions],
                (newValue) =>
                    setState(() => _editedNote.impressions = newValue.first),
              ),
              _buildEditableCard(
                'Who Should Read It?',
                [_editedNote.whoShouldRead],
                (newValue) =>
                    setState(() => _editedNote.whoShouldRead = newValue.first),
              ),
              _buildEditableCard(
                'My Top 3 Quotes',
                _editedNote.topThreeQuotes,
                (newValue) =>
                    setState(() => _editedNote.topThreeQuotes = newValue),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onSave(_editedNote);
                    Navigator.of(context).pop();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableCard(
      String title, List<String> content, Function(List<String>) onChanged) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...content.asMap().entries.map((entry) {
              return TextFormField(
                initialValue: entry.value,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Item ${entry.key + 1}',
                ),
                onChanged: (newValue) {
                  List<String> updatedContent = List.from(content);
                  updatedContent[entry.key] = newValue;
                  onChanged(updatedContent);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
