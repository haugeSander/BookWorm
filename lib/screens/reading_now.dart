import 'dart:io';

import 'package:book_worm/screens/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_worm/models/book.dart';

import '../services/isar_service.dart';

class ReadingNowPage extends StatelessWidget {
  const ReadingNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          StreamBuilder<List<Book>>(
              stream: IsarService().getBooksOfStatus(BookStatus.started),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No books found'));
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
          openAddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future openAddDialog(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Fedda liker gutter!'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter why'),
            ),
            actions: [
              TextButton(
                  child: Text('SUBMIT'),
                  onPressed: () {
                    submit(context);
                  })
            ],
          ));

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetailPage(
                                book: books[index],
                              )),
                    );
                  },
                  child: Container(
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
                          Icon(
                            books[index].status == BookStatus.finished
                                ? Icons.check
                                : Icons.library_add,
                          ),
                        ]),
                  ));
            })
      ],
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
}
