import 'dart:io';

import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/models/user.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/library.dart';
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
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              sliver: SliverToBoxAdapter(child: _profileAndTitle(context)),
            ),
            SliverToBoxAdapter(child: _buildWelcomeSection()),
            SliverToBoxAdapter(child: _buildQuickStats()),
            SliverToBoxAdapter(child: _buildReadingNowSection(context)),
          ],
        ),
      ),
    );
  }

  void submit(context) {
    Navigator.of(context).pop();
  }

  Widget _buildQuickStats() {
    return FutureBuilder<Map<String, dynamic>>(
      future: IsarService().getStatistics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final stats = snapshot.data!;
          return Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(Icons.book, stats['totalBooks'].toString(),
                      'Total Books'),
                  _buildStatItem(Icons.auto_stories,
                      stats['booksInProgress'].toString(), 'In Progress'),
                  _buildStatItem(
                      Icons.done, stats['finishedBooks'].toString(), 'Finished')
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<User?>(
        future: IsarService().getUser(),
        builder: (context, snapshot) {
          final userName = snapshot.data?.firstName ?? 'Book Lover';
          return Text(
            'Welcome back, $userName!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
          );
        },
      ),
    );
  }

  Widget _buildReadingNowSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Reading Now',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LibraryPage()));
                  },
                  child: const Text('See All', style: TextStyle(color: Colors.blue),)),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: StreamBuilder<List<Book>>(
            stream: IsarService()
                .getBooksOfStatus([BookStatus.reading, BookStatus.listening]),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No books found'));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      _buildBookCard(context, snapshot.data![index]),
                );
              }
            }),
          ),
        ),
      ],
    );
  }

Widget _buildBookCard(BuildContext context, Book book) {
  return GestureDetector(
    onTap: () => _openAddNote(context, book.userDataReference.value!),
    child: Stack(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(left: 16, right: 8, bottom: 16),
          child: SizedBox(
            width: 140,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: book.coverImage.isEmpty
                      ? Container(
                          height: 120,
                          color: Colors.grey[200],
                          child: const Icon(Icons.book, size: 50, color: Colors.grey))
                      : Image.file(
                          File(book.coverImage),
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        book.author,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.note_add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

  Future _openAddNote(BuildContext context, UserBookEntry book) {
    DateTime? selectedDate;
    final noteController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
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
                content: SizedBox(
                  width: double.maxFinite,
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
                                    : DateFormat('MMMM d, y')
                                        .format(selectedDate!),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: selectedDate == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              const Icon(Icons.calendar_today,
                                  color: Colors.blue),
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
                      if (selectedDate != null &&
                          noteController.text.isNotEmpty) {
                        final newNote = BookNotes(
                            timeOfNote: selectedDate!,
                            noteContent: noteController.text,
                            noteNumber: book.bookNote.length + 1,
                            statusWhenNoted: book.status);
                        newNote.bookReference.value = book;
                        IsarService().saveBookNote(newNote);
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please select a date and enter a note.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
            child: _loadProfileImage(),
          ),
          const Text(
            "Book worm",
            style: TextStyle(
                color: Colors.black, fontSize: 38, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  FutureBuilder<User?> _loadProfileImage() {
    return FutureBuilder<User?>(
      future: IsarService().getUser().then((future) => future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          final user = snapshot.data;
          return ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: _buildProfileImage(user?.profileImage),
          );
        }
      },
    );
  }

  Widget _buildProfileImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return const Icon(Icons.person, size: 80.0);
    }

    return Image.file(
      File(imagePath),
      width: 80.0,
      height: 80.0,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.person, size: 80.0),
    );
  }
}
