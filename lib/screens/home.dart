import 'dart:io';

import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/models/user.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/user_and_settings.dart';
import 'package:flutter/material.dart';
import 'package:book_worm/models/book.dart';
import 'package:intl/intl.dart';

import '../services/isar_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  DateTime? selectedDate;
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 50,
          ),
          _profileAndTitle(context),
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Reading now',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          StreamBuilder<List<Book>>(
              stream: IsarService()
                  .getBooksOfStatus([BookStatus.reading, BookStatus.listening]),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No books found'));
                } else {
                  return _bookList(snapshot.data!);
                }
              })),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  void submit(context) {
    Navigator.of(context).pop();
  }

  Widget _bookList(List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          itemCount: books.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            final book = books[index];
            return GestureDetector(
              onTap: () {
                _openAddNote(context, books[index].userDataReference.value!);
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: book.coverImage.isEmpty
                          ? Container(
                              width: 80,
                              color: Colors.grey[200],
                              child: const Center(child: Text('No image')),
                            )
                          : Image.file(
                              File(book.coverImage),
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book.author,
                            style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          if (book.userDataReference.value!
                                  .dateOfCurrentStatus !=
                              null)
                            Text(
                              'Started: ${DateFormat('MMMM d, y').format(book.userDataReference.value!.dateOfCurrentStatus!)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                                fontSize: 10,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.note_add,
                      size: 35,
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Future _openAddNote(BuildContext context, UserBookEntry book) {
    DateTime? selectedDate;
    final noteController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Add Note',
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
                    book.bookReference.value!.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Date of Note:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2017, 9, 7),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate == null
                                ? 'Select Date'
                                : DateFormat('MMMM d, y').format(selectedDate!),
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedDate == null
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          const Icon(Icons.calendar_today, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Note:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: noteController,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Enter your note here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: const Text('Add Note'),
                onPressed: () {
                  if (selectedDate != null && noteController.text.isNotEmpty) {
                    final newNote = BookNotes(
                        timeOfNote: selectedDate!,
                        noteContent: noteController.text,
                        noteNumber: book.bookNote.length + 1,
                        statusWhenNoted: book.status);
                    newNote.bookReference.value = book;
                    IsarService().saveBookNote(newNote);
                    Navigator.of(context).pop();
                  } else {
                    // Show an error message if date is not selected or note is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a date and enter a note.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Reading now',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }

  Widget _profileAndTitle(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserSettingsPage()),
              );
            },
            child: FutureBuilder<User?>(
              future: IsarService().getUser().then((future) => future),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error);
                } else {
                  final user = snapshot.data;
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: user?.profileImage != null &&
                            user!.profileImage!.isNotEmpty
                        ? Image.asset(
                            user.profileImage!,
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 80.0),
                          )
                        : const Icon(Icons.person, size: 80.0),
                  );
                }
              },
            ),
          ),
          const Text(
            "Book worm",
            style: TextStyle(
                color: Colors.black, fontSize: 34, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
