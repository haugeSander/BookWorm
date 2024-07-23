import 'package:book_worm/screens/edit_findings.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailFindings extends StatelessWidget {
  const BookDetailFindings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
        final finalNote = state.finalNote;
        if (finalNote == null) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    "Your Findings",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                  if (state.isEditMode)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editFindings(context, state),
                    ),
                ],
              ),
            ),
            if (finalNote.inThreeSentences.isNotEmpty)
              _buildCard(
                title: "🚀 The Book in 3 Sentences",
                content: _buildNumberedList(finalNote.inThreeSentences),
              ),
            if (finalNote.impressions.isNotEmpty)
              _buildCard(
                title: "🎨 Impressions",
                content: Text(finalNote.impressions),
              ),
            if (finalNote.whoShouldRead.isNotEmpty)
              _buildCard(
                title: "🎓 Who Should Read It?",
                content: Text(finalNote.whoShouldRead),
              ),
            if (finalNote.topThreeQuotes.isNotEmpty)
              _buildCard(
                title: "✍️ My Top 3 Quotes",
                content: _buildNumberedList(
                  finalNote.topThreeQuotes
                      .map((quote) => "\"$quote\"")
                      .toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  void _editFindings(BuildContext context, BookDetailState state) async {
    if (state.somethingChanged) {
      final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Save changes?"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop('save'),
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop('discard'),
                  child: const Text("Discard"),
                ),
              ],
            ),
          );
        },
      );

      if (result == 'save') {
        state.saveChanges();
      } else if (result == 'discard') {
        state.discardChanges();
      } else {
        return; // User dismissed the dialog without choosing
      }
      state.toggleSomethingChanged();
    }

    state.toggleEditMode();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditFindingsPage(
          book: state.book,
          finalNote: state.finalNote!,
          onSave: (updatedNote) => state.updateFinalNote(updatedNote),
        ),
      ),
    );
  }

  Card _buildCard({required String title, required Widget content}) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildNumberedList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  "${entry.key + 1}.",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(entry.value),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
