import 'dart:io';

import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/book_detail.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

enum SortOption { title, author, dateAdded }

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
  String search = "";
  BookStatus? selectedStatus;
  SortOption selectedSort = SortOption.dateAdded;
  bool sortAscending = true;
  bool showFilters = false;

  File? _imageLoaded;
  final picker = ImagePicker();

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
          if (showFilters) ...[
            const SizedBox(height: 10),
            _filterChips(),
            const SizedBox(height: 10),
            _sortChips(),
          ],
          const SizedBox(
            height: 40,
          ),
          StreamBuilder<List<Book>>(
              stream: _applyFiltersAndSort(IsarService().getAllBooks()),
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
          File? newImage;
          if (result == null || result.isEmpty) return;
          if (_imageLoaded != null) {
            // getting a directory path for saving
            final applicationDirectory =
                await getApplicationDocumentsDirectory();
            final path = applicationDirectory.path;
            // copy the file to a new path
            newImage = await _imageLoaded!.copy('$path/${result['name']}.jpg');
          }
          final newBook = Book(
              title: result['name']!,
              author: result['author']!,
              coverImage: newImage == null ? "" : newImage.path);

          final newUserDataBook = UserBookEntry(
              bookId: newBook.bookId,
              status: _dropdownValue,
              dateOfCurrentStatus: DateTime.now());

          if (_dropdownValue == BookStatus.listening ||
              _dropdownValue == BookStatus.reading) {
            newUserDataBook.timeStarted = DateTime.now();
          }

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
            textCapitalization: TextCapitalization.words,
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

  Widget _bookList(List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Your added books',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => BookDetailState(
                          book: book,
                          userData: book.userDataReference.value!,
                          finalNote:
                              book.userDataReference.value!.finishedNote.value),
                      child: const BookDetailPage(),
                    ),
                  ),
                );
              },
              onLongPress: () {
                _showDeleteOption(context, book);
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
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _getCorrespondingIcon(book.userDataReference.value!),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showDeleteOption(BuildContext context, Book bookToRemove) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Book'),
          content: const Text(
              'Are you sure you want to delete this book? \nIt is non-reversible, and all corresponding data will be removed!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                // Close the dialog
                Navigator.of(context).pop();

                // Perform the delete operation
                bool success = await IsarService().deleteBook(bookToRemove);

                if (success) {
                  // If the delete was successful, update the state
                  setState(() {});

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Book deleted successfully')),
                  );
                } else {
                  // Show an error message if the delete failed
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete the book')),
                  );
                }
              },
            ),
          ],
        );
      },
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
            suffixIcon: IconButton(
              icon: SvgPicture.asset('assets/icons/Filter.svg'),
              onPressed: () {
                setState(() {
                  showFilters = !showFilters;
                });
              },
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

  Widget _filterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: BookStatus.values.map((status) {
            Color chipColor = _getCorrespondingColor(status);
            Color lightChipColor = Color.lerp(chipColor, Colors.white, 0.7)!;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(
                  status.toString().split('.').last.capitalize(),
                  style: TextStyle(
                    color: selectedStatus == status ? Colors.white : chipColor,
                  ),
                ),
                selected: selectedStatus == status,
                selectedColor: chipColor,
                backgroundColor: lightChipColor,
                onSelected: (bool selected) {
                  setState(() {
                    selectedStatus = selected ? status : null;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _sortChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: SortOption.values.map((sort) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(
                  'Sort by ${sort.toString().split('.').last.capitalize()}',
                  style: TextStyle(
                    color: selectedSort == sort ? Colors.white : Colors.black,
                  ),
                ),
                selected: selectedSort == sort,
                selectedColor: Colors.blue,
                backgroundColor: Colors.blue.withOpacity(0.1),
                onSelected: (bool selected) {
                  setState(() {
                    if (selectedSort == sort) {
                      sortAscending = !sortAscending;
                    } else {
                      selectedSort = sort;
                      sortAscending = true;
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Stream<List<Book>> _applyFiltersAndSort(Stream<List<Book>> bookStream) {
    return bookStream.map((books) {
      List<Book> filteredBooks = books;

      // Apply status filter
      if (selectedStatus != null) {
        filteredBooks = filteredBooks
            .where((book) =>
                book.userDataReference.value?.status == selectedStatus)
            .toList();
      }

      // Apply search filter
      if (search.isNotEmpty) {
        filteredBooks = filteredBooks
            .where((book) =>
                book.title.toLowerCase().contains(search.toLowerCase()) ||
                book.author.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }

      // Apply sorting
      filteredBooks.sort((a, b) {
        int compare;
        switch (selectedSort) {
          case SortOption.title:
            compare = a.title.compareTo(b.title);
            break;
          case SortOption.author:
            compare = a.author.compareTo(b.author);
            break;
          case SortOption.dateAdded:
            compare = (a.userDataReference.value?.dateOfCurrentStatus ??
                    DateTime.now())
                .compareTo(b.userDataReference.value?.dateOfCurrentStatus ??
                    DateTime.now());
            break;
        }
        return sortAscending ? compare : -compare;
      });

      return filteredBooks;
    });
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

  Color _getCorrespondingColor(BookStatus status) {
    switch (status) {
      case BookStatus.finished:
        return Colors.green;
      case BookStatus.reading:
        return Colors.teal;
      case BookStatus.listening:
        return Colors.amber;
      case BookStatus.dropped:
        return Colors.red;
      case BookStatus.added:
        return Colors.black;
    }
  }
}
