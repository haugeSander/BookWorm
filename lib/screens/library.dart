import 'dart:io';

import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/book_detail.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// Add this extension method to capitalize the first letter of a string
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late TextEditingController bookNameController;
  late TextEditingController authorController;
  late TextEditingController imageController;
  late BookStatus _dropdownValue = BookStatus.added;
  File? _imageLoaded;
  final picker = ImagePicker();
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
          // getting a directory path for saving
          final applicationDirectory = await getApplicationDocumentsDirectory();
          final path = applicationDirectory.path;
          // copy the file to a new path
          final File newImage =
              await _imageLoaded!.copy('$path/${result['name']}.jpg');

          final newUserDataBook = UserBookEntry(
              status: _dropdownValue,
              dateOfCurrentStatus:
                  _dropdownValue == BookStatus.added ? DateTime.now() : null);

          final newBook = Book(
              title: result['name']!,
              author: result['author']!,
              coverImage: _imageLoaded == null ? "" : newImage.path);

          // Establish the link between the UserBookEntry and Book
          newUserDataBook.bookReference.value = newBook;
          newBook.userDataReference.value = newUserDataBook;

          IsarService().saveBook(newBook, newUserDataBook);
          _imageLoaded = null;
        }),
        child: const Icon(Icons.book),
      ),
    );
  }

  Future<Map<String, String>?> openAddDialog(BuildContext context) {
    return showGeneralDialog<Map<String, String>>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return Scaffold(
              appBar: AppBar(
                title: const Center(
                    child: Text(
                  'Add Book to Library',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _imageLoaded = null;
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField('Title', bookNameController),
                      const SizedBox(height: 16.0),
                      _buildInputField('Author', authorController),
                      const SizedBox(height: 16.0),
                      _buildDropdownField('Status'),
                      const SizedBox(height: 20.0),
                      _buildCoverImageSection(context, setDialogState),
                      const SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton(
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add),
                              Text(
                                'Add book',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (bookNameController.text.isEmpty ||
                                authorController.text.isEmpty) {
                              const message = SnackBar(
                                content: Text("Invalid title or author!"),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(message);
                            } else {
                              final bookData = {
                                'name': bookNameController.text,
                                'author': authorController.text,
                              };
                              submit(context, bookData);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          alignment: Alignment.bottomRight,
          child: child,
        );
      },
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            maxLines: 1,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              border: OutlineInputBorder(),
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<BookStatus>(
            value: _dropdownValue,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              border: OutlineInputBorder(),
            ),
            items: BookStatus.values.map((BookStatus status) {
              return DropdownMenuItem<BookStatus>(
                value: status,
                child: Text(
                  status.toString().split('.').last.capitalize(),
                ),
              );
            }).toList(),
            onChanged: (BookStatus? newValue) {
              setState(() {
                _dropdownValue = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCoverImageSection(
      BuildContext context, StateSetter setDialogState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cover image',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  image: _imageLoaded != null
                      ? DecorationImage(
                          image: FileImage(File(_imageLoaded!.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _imageLoaded == null
                    ? const Center(
                        child: Text(
                          'No image',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : null,
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () async {
                    await _showOptions(context, setDialogState);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void submit(context, bookData) {
    Navigator.of(context).pop(bookData);
    bookNameController.clear();
    authorController.clear();
  }

  Future<void> _showOptions(
      BuildContext context, StateSetter setDialogState) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _getImage(ImageSource.gallery);
                  setDialogState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _getImage(ImageSource.camera);
                  setDialogState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _imageLoaded = File(pickedFile.path);
    }
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
                          _getCorrespondingIcon(
                              books[index].userDataReference.value!),
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
