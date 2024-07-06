import 'dart:io';

import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:flutter/material.dart';
import 'package:book_worm/models/book.dart';
import 'package:flutter_svg/svg.dart';

import '../services/isar_service.dart';

class ReadingNowPage extends StatelessWidget {
  ReadingNowPage({super.key});
  DateTime? selectedDate;
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddCurrentlyReading(context);
        },
        child: const Icon(Icons.chrome_reader_mode),
      ),
    );
  }

  Future openAddCurrentlyReading(context) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add a book you are currently reading'),
              content: StreamBuilder<List<Book>>(
                  stream: IsarService().getAllBooks(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No books found'));
                    } else {
                      final books = snapshot.data!;
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            ListView.separated(
                                itemCount: books.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 25,
                                    ),
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  left: 20,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: SizedBox(
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(books[index].title),
                                          ],
                                        )),
                                  );
                                })
                          ]);
                    }
                  })),
              actions: [
                TextButton(
                    child: const Text('Done'),
                    onPressed: () {
                      submit(context);
                    })
              ],
            );
          }));

  void submit(context) {
    Navigator.of(context).pop();
  }

  Column _bookList(List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        ListView.separated(
            itemCount: books.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    _openAddNote(
                        context, books[index].userDataReference.value!);
                  },
                  child: SizedBox(
                    height: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          books[index].coverImage == ""
                              ? const SizedBox(
                                  width: 100.0,
                                  height: 100.0,
                                  child: Card(
                                      child: Center(child: Text('No image'))),
                                )
                              : Image.file(
                                  File(books[index].coverImage),
                                  width: 100,
                                  height: 100,
                                ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                books[index].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Text(
                                books[index].author,
                                style: const TextStyle(
                                    color: Color(0xff7B6F72),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          _getCorrespondingIcon(
                              books[index].userDataReference.value!)
                        ]),
                  ));
            })
      ],
    );
  }

  Widget _getCorrespondingIcon(UserBookEntry book) {
    switch (book.status) {
      case BookStatus.finished:
        return const Icon(Icons.check);
      case BookStatus.reading:
        return SvgPicture.asset("assets/icons/reading_icon.svg",
            width: 24.0, height: 24.0);
      case BookStatus.listening:
        return const Icon(Icons.headphones);
      case BookStatus.dropped:
        return const Icon(Icons.block_outlined);
      case BookStatus.added:
        return SvgPicture.asset("assets/icons/added_icon.svg",
            width: 24.0, height: 24.0);
    }
  }

  Future _openAddNote(context, UserBookEntry book) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Add a note for: ${book.bookReference.value!.title}'),
              content:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Set date for note:"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today),
                        TextButton(
                          child: Text(
                            selectedDate == null
                                ? 'Select Date'
                                : selectedDate!
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0],
                          ),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2017, 9, 7),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Note:"),
                TextField(
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: noteController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter note',
                  ),
                )
              ]),
              actions: [
                TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      submit(context);
                    }),
                TextButton(
                    child: const Text('Add note'),
                    onPressed: () {
                      final newNote = BookNotes(
                        timeOfNote: selectedDate!,
                        noteContent: noteController.text,
                      );
                      newNote.bookReference.value = book;
                      IsarService().saveBookNote(newNote);
                      submit(context);
                    })
              ],
            );
          }));

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
}
