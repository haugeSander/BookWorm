import 'dart:io';

import 'package:book_worm/models/book.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late TextEditingController bookNameController;
  late TextEditingController authorController;
  late TextEditingController imageController;
  late BookStatus _dropdownValue = BookStatus.added;
  File? imageLoaded;
  String search = ""; //for searching

  @override
  void initState() {
    super.initState();

    bookNameController = TextEditingController();
    authorController = TextEditingController();
    imageController = TextEditingController();
  }

  @override
  void dispose() {
    bookNameController.dispose();
    authorController.dispose();
    imageController.dispose();
    search = "";
    super.dispose();
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
          StreamBuilder<List<Book>>(
              stream: IsarService().getAllBooks(search: search),
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
        onPressed: (() async {
          final result = await openAddDialog(context);
          if (result == null || result.isEmpty) return;
          final newBook = Book(
              title: result['name']!,
              author: result['author']!,
              status: _dropdownValue,
              coverImage: imageLoaded == null ? "" : imageLoaded!.path);
          IsarService().saveBook(newBook);
          imageLoaded = null;
        }),
        child: const Icon(Icons.book),
      ),
    );
  }

  Future<Map<String, String>?> openAddDialog(BuildContext context) {
    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add book to Library'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Title:'),
                      const Expanded(child: SizedBox()),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'title...',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0)),
                          controller: bookNameController,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Author:'),
                      const Expanded(child: SizedBox()),
                      Expanded(
                        child: TextField(
                          decoration:
                              const InputDecoration(hintText: 'author...'),
                          controller: authorController,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Status'),
                      const Expanded(child: SizedBox()),
                      Expanded(
                        child: DropdownButton(
                          value: _dropdownValue,
                          items: BookStatus.values.map((BookStatus item) {
                            return DropdownMenuItem<BookStatus>(
                                value: item,
                                child: Text(item.toString().split(".")[1]));
                          }).toList(),
                          onChanged: (BookStatus? newValue) {
                            setState(() {
                              _dropdownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [Text('Cover')],
                  ),
                  Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () async {
                        final returnedImage = await _pickImageFromGallery();

                        setState(() {
                          imageLoaded = returnedImage;
                        });
                      },
                    ),
                  ),
                  Center(
                      child: imageLoaded == null
                          ? const SizedBox(
                              width: 200.0,
                              height: 300.0,
                              child:
                                  Card(child: Center(child: Text('No image'))),
                            )
                          : Image.file(
                              File(imageLoaded!.path),
                              width: 200.0,
                              height: 300.0,
                            ))
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('SUBMIT'),
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
        });
      },
    );
  }

  void submit(context, bookData) {
    Navigator.of(context).pop(bookData);
    bookNameController.clear();
    authorController.clear();
  }

  Future<File?> _pickImageFromGallery() async {
    XFile? returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return null;
    return File(returnedImage.path);
  }

  Column _bookList(List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Your added books',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ListView.separated(
            itemCount: books.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      books[index].coverImage == ""
                          ? const SizedBox(
                              width: 100.0,
                              height: 100.0,
                              child:
                                  Card(child: Center(child: Text('No image'))),
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
            hintText: 'Search Books...',
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            suffixIcon: SizedBox(
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
        onChanged: (value) {
          setState(() {
            search = value;
          });
        },
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
    );
  }
}
