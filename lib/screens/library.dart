import 'dart:ffi';

import 'package:book_worm/models/book.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late TextEditingController bookNameController;
  late TextEditingController authorController;

  @override
  void initState() {
    super.initState();

    bookNameController = TextEditingController();
    authorController = TextEditingController();
  }

  @override
  void dispose() {
    bookNameController.dispose();
    authorController.dispose();
    super.dispose();
  }

  Future<List<Book>> _getInitialInfo() async {
    return await IsarService().getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(
            height: 40,
          ),
          FutureBuilder<List<Book>>(
            future: _getInitialInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No books found'));
              } else {
                return _bookList(snapshot.data!);
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          final result = await openAddDialog(context);
          if (result == null || result.isEmpty) return;
          final newBook =
              Book(name: result['name']!, author: result['author']!);
          IsarService().saveBook(newBook);
        }),
        child: const Icon(Icons.book),
      ),
    );
  }

  Future<Map<String, String>?> openAddDialog(BuildContext context) {
    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add new book'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('Name of book:'),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Book name...'),
                        controller: bookNameController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Author:'),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Author name...'),
                        controller: authorController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('SUBMIT'),
              onPressed: () {
                final bookData = {
                  'name': bookNameController.text,
                  'author': authorController.text,
                };
                submit(context, bookData);
              },
            ),
          ],
        );
      },
    );
  }

  void submit(context, bookData) {
    Navigator.of(context).pop(bookData);
    bookNameController.clear();
    authorController.clear();
  }

  Column _bookList(List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Popular',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ListView.separated(
            itemCount: books.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
                  height: 25,
                ),
            padding: EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            books[index].name,
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
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/button.svg',
                          width: 30,
                          height: 30,
                        ),
                      )
                    ]),
                decoration: BoxDecoration(
                    color: books[index].boxIsSelected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: books[index].boxIsSelected
                        ? [
                            BoxShadow(
                                color:
                                    const Color(0xff1D1617).withOpacity(0.07),
                                offset: const Offset(0, 10),
                                blurRadius: 40,
                                spreadRadius: 0)
                          ]
                        : []),
              );
            })
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search Pancake',
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            suffixIcon: Container(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Library',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
