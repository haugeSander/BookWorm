import 'dart:io';

import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:book_worm/widgets/book_summary_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  Future<List<BookNotes>> _getInfo() {
    return IsarService().getAllBookNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Your summary",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Recent notes',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w200),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _recentNoteScroll(),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Your book summary',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w200),
            ),
          ),
          const SizedBox(height: 20),
          const BookSummary(), // Add this line
        ],
      ),
    );
  }

  SizedBox _recentNoteScroll() {
    return SizedBox(
      height: 120,
      child: FutureBuilder(
        future: _getInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes found'));
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => const SizedBox(width: 25),
              itemBuilder: (BuildContext context, int index) {
                final bookNote = snapshot.data![index];
                final userData = bookNote.bookReference.value;
                final book = userData!.bookReference.value;
                final bookStatus = bookNote.statusWhenNoted;
                final noteNumber = index + 1; // Assuming 1-based indexing

                return GestureDetector(
                  onTap: () {
                    _noteDialog(context, snapshot, bookNote);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Main circle with status color and icon
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getCorrespondingColor(bookStatus),
                        ),
                      ),
                      // Status icon
                      Positioned(
                        top: 25, // Adjust this value for desired top padding
                        child: _getCorrespondingIcon(bookStatus),
                      ),
                      // Note number
                      Positioned(
                        bottom: 40,
                        child: Text(
                          '$noteNumber',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Book cover image
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: book!.coverImage.isNotEmpty
                              ? Image.file(
                                  File(book.coverImage),
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(
                                  height: 40,
                                  width: 40,
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Color _getCorrespondingColor(BookStatus status) {
    switch (status) {
      case BookStatus.finished:
        return Colors.lightGreen;
      case BookStatus.reading:
        return Colors.blueAccent;
      case BookStatus.listening:
        return Colors.amber;
      case BookStatus.dropped:
        return Colors.orange;
      case BookStatus.added:
        return Colors.teal;
    }
  }

  Widget _getCorrespondingIcon(BookStatus status) {
    switch (status) {
      case BookStatus.finished:
        return const Icon(Icons.check, size: 30.0);
      case BookStatus.reading:
        return SvgPicture.asset("assets/icons/reading_icon.svg",
            width: 30.0, height: 30.0);
      case BookStatus.listening:
        return const Icon(Icons.headphones, size: 30);
      case BookStatus.dropped:
        return const Icon(Icons.block_outlined, size: 30);
      case BookStatus.added:
        return SvgPicture.asset("assets/icons/added_icon.svg",
            width: 30.0, height: 30.0);
    }
  }

  Future<Map<String, String>?> _noteDialog(BuildContext context,
      AsyncSnapshot<List<BookNotes>> snapshot, BookNotes note) {
    bool isEditing = false;
    TextEditingController editingController =
        TextEditingController(text: note.noteContent);

    return showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              note.bookReference.value!.bookReference.value!.title,
              style: const TextStyle(
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
                  const Text(
                    "Note:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "Noted on ${DateFormat('MMMM d, y').format(note.timeOfNote)}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
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
}
