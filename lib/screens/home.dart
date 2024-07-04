import 'dart:io';

import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
            height: 40,
          ),
          _profileAndTitle(),
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
              return const Center(child: Text('No books found'));
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 25,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        _noteDialog(context, snapshot, snapshot.data![index]);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                            File(snapshot
                                .data![index].bookReference.value!.coverImage),
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill),
                      ));
                },
              );
            }
          },
        ));
  }

  Future<Map<String, String>?> _noteDialog(BuildContext context,
      AsyncSnapshot<List<BookNotes>> snapshot, BookNotes note) {
    return showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Note for ${note.bookReference.value!.title}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Container(
            padding: const EdgeInsets.all(10.0),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.noteContent,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  "Noted on ${note.timeOfNote.toString().split(" ").first}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Center _profileAndTitle() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: const Image(
              image: AssetImage('assets/images/mark_manson.jpg'),
              width: 80.0,
              height: 80.0,
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
