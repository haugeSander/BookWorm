import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookDetailNotes extends StatelessWidget {
  const BookDetailNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(builder: (context, state, child) {
      var userData = state.userData;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notes",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: userData.bookNote.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final note = userData.bookNote.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    _showEditNoteDialog(context, note);
                  },
                  onLongPress: () {
                    _showDeleteNoteDialog(context, state, note);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: 18, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('MMMM d, y').format(note.timeOfNote),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            note.noteContent,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  void _showEditNoteDialog(BuildContext context, BookNotes note) {
    bool isEditing = false;
    TextEditingController editingController =
        TextEditingController(text: note.noteContent);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "Edit Note",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Noted on ${DateFormat('MMMM d, y').format(note.timeOfNote)}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  isEditing
                      ? TextField(
                          controller: editingController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Text(
                          note.noteContent,
                          style: const TextStyle(fontSize: 16),
                        ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (isEditing) {
                    // Save the edited note
                    note.noteContent = editingController.text;
                    IsarService().updateBookNote(note).then((_) {
                      Navigator.of(context).pop();
                      // Refresh the page to show updated note
                      setState(() {});
                    });
                  } else {
                    // Enter editing mode
                    setState(() {
                      isEditing = true;
                    });
                  }
                },
                child: Text(isEditing ? "Save" : "Edit"),
              ),
            ],
          );
        });
      },
    );
  }

  void _showDeleteNoteDialog(
      BuildContext context, BookDetailState state, BookNotes note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                state.deleteNote(note);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
