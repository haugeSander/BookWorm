import 'dart:io';
import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/library.dart';
import 'package:book_worm/screens/stepper_page.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:book_worm/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late final Book book;
  late final UserBookEntry userData;
  late final FinishedBookNote? finalNote;
  late final Color color;
  late final bool isFinished;
  //File? _imageLoaded;

  @override
  void initState() {
    super.initState();
    book = widget.book;
    userData = book.userDataReference.value!;
    isFinished = userData.status == BookStatus.finished;
    finalNote = userData.finishedNote.value;
    color = _getCorrespondingColor(userData.status);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildHeader(context),
      const SizedBox(height: 8.0),
      Expanded(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // This aligns all children to the start
                      children: [
                        _buildTagSection(),
                        const SizedBox(height: 16.0), // Add some spacing
                        _buildCardView(),
                        const SizedBox(height: 16.0), // Add some spacing
                        _buildSummerySection(),
                        const SizedBox(height: 16.0), // Add some spacing
                        _buildGallerySection(),
                        const SizedBox(height: 16.0), // Add some spacing
                        _buildNotesSection(),
                        const SizedBox(height: 16.0), // Add some spacing
                      ]))))
    ]));
  }

  Widget _buildNotesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Notes",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 8), // Small gap between title and list
          ListView.separated(
            padding: EdgeInsets.zero, // Remove default padding
            itemCount: userData.bookNote.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final note = userData.bookNote.elementAt(index);
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 18, color: Colors.blue[700]),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('MMMM d, y').format(note.timeOfNote),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          note.noteContent,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Gallery",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: userData.gallery!.length + 1,
              itemBuilder: (context, index) {
                if (index < userData.gallery!.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                            imagePath: userData.gallery![index],
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          File(userData.gallery![index]),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          onPressed: () async {
                            await _showOptions(context);
                          },
                          iconSize: 30,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showOptions(BuildContext context) async {
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
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _getImage(ImageSource.camera);
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
      final File imageFile = File(pickedFile.path);
      await _saveImage(imageFile);
    }
  }

  Future<void> _saveImage(File imageFile) async {
    final applicationDirectory = await getApplicationDocumentsDirectory();
    final path = applicationDirectory.path;
    final fileName =
        '${book.title}-${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File newImage = await imageFile.copy('$path/$fileName');

    setState(() {
      userData.gallery.add(newImage.path);
    });

    await IsarService().updateUserDataEntry(userData);
  }

  Widget _buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Summary",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
              height: 8.0), // Add some spacing between title and summary
          Text(book.summary ?? "") // Using null-aware operator for cleaner code
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 175, // Fixed height for the header
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(book.coverImage),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: _buildHeaderCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    book.author,
                    style: const TextStyle(fontSize: 18.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 40,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Chip(
            label: Text(
              userData.status.name.capitalize(),
              style: const TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: color),
            ),
            backgroundColor: color,
          ),
        ],
      ),
    );
  }

  Widget _buildCardView() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildCardViewText(),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: _buildRatingBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardViewText() {
    final dateFormat = DateFormat('MMMM d, y');
    final formattedDate = userData.dateOfCurrentStatus != null
        ? dateFormat.format(userData.dateOfCurrentStatus!)
        : "";

    switch (userData.status) {
      case BookStatus.finished:
        return _buildFinishedText(formattedDate);
      case BookStatus.dropped:
        return _buildDroppedText(formattedDate);
      case BookStatus.added:
        return _buildAddedText(formattedDate);
      default:
        return _buildStartedText(formattedDate);
    }
  }

  Widget _buildFinishedText(String startDate) {
    return Column(
      children: [
        const Text(
          "Book finished",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        Text("Started: $startDate"),
        if (finalNote != null && isFinished) ...[
          Text(
              "Finished: ${DateFormat('MMMM d, y').format(finalNote!.timeEnded)}"),
          const SizedBox(height: 10.0),
          const Text(
            'Score given',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDroppedText(String stopDate) {
    return Column(
      children: [
        const Text(
          "Book dropped",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        Text("Stopped: $stopDate"),
        const SizedBox(height: 10.0),
        _buildActionButton("Continue?"),
      ],
    );
  }

  Widget _buildAddedText(String addedDate) {
    return Column(
      children: [
        const Text(
          "Book not started",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text("Added: $addedDate"),
        _buildActionButton("Started?"),
      ],
    );
  }

  Widget _buildStartedText(String startDate) {
    return Column(
      children: [
        const Text(
          "Book started",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        Text("Started: $startDate"),
        const SizedBox(height: 10.0),
        _buildActionButton("Finished?"),
      ],
    );
  }

  Widget _buildActionButton(String text) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StepperPage(bookEntry: userData),
            ));
      },
      borderRadius: BorderRadius.circular(20),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> _buildRatingBar() {
    return [
      _getCorrespondingIcon(userData.status),
      if (userData.status == BookStatus.finished && finalNote != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: finalNote!.rating < 6
              ? RatingBar(
                  minRating: 1,
                  maxRating: 5,
                  initialRating: finalNote!.rating.toDouble(),
                  ignoreGestures: true,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.yellow),
                    half: const Icon(Icons.star_half, color: Colors.yellow),
                    empty: const Icon(Icons.star_border),
                  ),
                  allowHalfRating: false,
                  itemSize: 20,
                  onRatingUpdate: (_) {},
                )
              : const Chip(
                  label: Text("Life-changing"),
                  backgroundColor: Colors.teal,
                ),
        )
    ];
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

  Widget _getCorrespondingIcon(BookStatus status) {
    switch (status) {
      case BookStatus.finished:
        return SvgPicture.asset("assets/icons/finished_medal.svg",
            width: 75.0, height: 75.0);
      case BookStatus.reading:
        return SvgPicture.asset("assets/icons/reading_icon.svg",
            width: 75.0, height: 75.0);
      case BookStatus.listening:
        return const Icon(Icons.headphones, size: 75);
      case BookStatus.dropped:
        return const Icon(Icons.block_outlined, size: 75);
      case BookStatus.added:
        return SvgPicture.asset("assets/icons/added_icon.svg",
            width: 75.0, height: 75.0);
    }
  }
}

class ImageDialog extends StatelessWidget {
  final String imagePath;

  const ImageDialog({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
