import 'dart:io';
import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/book_notes.dart';
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
                        const SizedBox(height: 24.0), // Add some spacing
                        _buildCardView(),
                        const SizedBox(height: 24.0), // Add some spacing
                        _buildSummarySection(),
                        const SizedBox(height: 24.0), // Add some spacing
                        _buildYourFindingsSection(),
                        const SizedBox(height: 24.0), // Add some spacing
                        _buildGallerySection(),
                        const SizedBox(height: 24.0), // Add some spacing
                        _buildNotesSection(),
                        const SizedBox(height: 24.0), // Add some spacing
                      ]))))
    ]));
  }

  Widget _buildYourFindingsSection() {
    if (finalNote == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Your Findings",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
        ),
        if (finalNote!.inThreeSentences.isNotEmpty)
          _buildCard(
            title: "🚀 The Book in 3 Sentences",
            content: _buildNumberedList(finalNote!.inThreeSentences),
          ),
        if (finalNote!.impressions.isNotEmpty)
          _buildCard(
            title: "🎨 Impressions",
            content: Text(finalNote!.impressions),
          ),
        if (finalNote!.whoShouldRead.isNotEmpty)
          _buildCard(
            title: "🎓 Who Should Read It?",
            content: Text(finalNote!.whoShouldRead),
          ),
        if (finalNote!.topThreeQuotes.isNotEmpty)
          _buildCard(
            title: "✍️ My Top 3 Quotes",
            content: _buildNumberedList(
              finalNote!.topThreeQuotes.map((quote) => "\"$quote\"").toList(),
            ),
          ),
      ],
    );
  }

  Card _buildCard({required String title, required Widget content}) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildNumberedList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  "${entry.key + 1}.",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(entry.value),
              ),
            ],
          ),
        );
      }).toList(),
    );
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
          const SizedBox(height: 8),
          ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: userData.bookNote.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final note = userData.bookNote.elementAt(index);
              return GestureDetector(
                onTap: () {
                  _showEditNoteDialog(context, note);
                },
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

  void _showEditNoteDialog(BuildContext context, BookNotes note) {
    bool isEditing = false;
    TextEditingController editingController =
        TextEditingController(text: note.noteContent);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "Edit Note",
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
                    "Noted on ${DateFormat('MMMM d, y').format(note.timeOfNote)}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  isEditing
                      ? TextField(
                          controller: editingController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Text(
                          note.noteContent,
                          style: const TextStyle(fontSize: 16),
                        ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (isEditing) {
                    // Save the edited note
                    note.noteContent = editingController.text;
                    IsarService().updateBookNote(note).then((_) {
                      Navigator.of(context).pop();
                      // Refresh the page to show updated note
                      setState(() {});
                    });
                  } else {
                    // Enter editing mode
                    setState(() {
                      isEditing = true;
                    });
                  }
                },
                child: Text(isEditing ? "Save" : "Edit"),
              ),
            ],
          );
        });
      },
    );
  }

  Widget _buildGallerySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              itemCount: userData.gallery.length + 1,
              itemBuilder: (context, index) {
                if (index < userData.gallery.length) {
                  return GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => ImageDialog(
                          imagePath: userData.gallery[index],
                        ),
                      );
                    },
                    onLongPress: () {
                      _showDeleteOption(context, index);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(userData.gallery[index]),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
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

  void _showDeleteOption(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Image'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  File(userData.gallery[index]).delete();
                  userData.gallery.removeAt(index);
                  IsarService().updateUserDataEntry(userData);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Summary",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _openSummaryDialog();
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ))
            ],
          ),
          const SizedBox(
              height: 8.0), // Add some spacing between title and summary
          Text(book.summary ?? ""),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  void _openSummaryDialog() {
    final TextEditingController summaryController =
        TextEditingController(text: book.summary);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Summary',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: summaryController,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Enter book summary...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
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
              onPressed: () {
                setState(() {
                  IsarService().updateBookSummary(book, summaryController.text);
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 175, // Fixed height for the header
      child: Stack(
        children: [
          Positioned.fill(
            child: book.coverImage != ""
                ? Image.file(
                    File(book.coverImage),
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey,
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
    var finishedNote = userData.finishedNote.value;

    List<Widget> chips = [];

    // Add the status chip
    chips.add(_buildChip(
        userData.status.name, _getCorrespondingColor(userData.status)));

    // Add tag chips if finishedNote is not null and has tags
    if (finishedNote != null && finishedNote.tags.isNotEmpty) {
      chips.addAll(finishedNote.tags
          .map((tag) => _buildChip(tag, _getColorForTag(tag))));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: chips,
      ),
    );
  }

  Widget _buildChip(String label, Color backgroundColor) {
    final textColor = _getContrastingTextColor(backgroundColor);
    return Chip(
      label: Text(
        label.capitalize(),
        style: TextStyle(color: textColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: backgroundColor),
      ),
      backgroundColor: backgroundColor,
    );
  }

  Color _getColorForTag(String tag) {
    final hash = tag.hashCode;
    final hue = (hash % 360).toDouble();
    return HSLColor.fromAHSL(1.0, hue, 0.7, 0.5).toColor();
  }

  Color _getContrastingTextColor(Color backgroundColor) {
    // Calculate the relative luminance of the background color
    double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;

    // Choose white for dark backgrounds and black for light backgrounds
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Widget _buildCardView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildCardViewText(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _getCorrespondingIcon(userData.status),
                  ),
                ],
              ),
              if (userData.status == BookStatus.finished) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Score given',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    _buildRatingBar(),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardViewText() {
    final dateFormat = DateFormat('MMM d, y');
    final formattedCurrentStatusDate = userData.dateOfCurrentStatus != null
        ? dateFormat.format(userData.dateOfCurrentStatus!)
        : "";
    final formattedStartDate = userData.timeStarted != null
        ? dateFormat.format(userData.timeStarted!)
        : "";

    switch (userData.status) {
      case BookStatus.finished:
        return _buildFinishedText(formattedStartDate);
      case BookStatus.dropped:
        return _buildDroppedText(formattedCurrentStatusDate);
      case BookStatus.added:
        return _buildAddedText(formattedCurrentStatusDate);
      default:
        return _buildStartedText(formattedCurrentStatusDate);
    }
  }

  Widget _buildFinishedText(String startDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Book finished",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Started: $startDate"),
        ),
        if (finalNote != null && isFinished) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Finished: ${DateFormat('MMMM d, y').format(finalNote!.timeEnded)}",
            ),
          ),
          const SizedBox(height: 10.0)
        ],
      ],
    );
  }

  Widget _buildDroppedText(String stopDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Book dropped",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Stopped: $stopDate"),
        ),
        const SizedBox(height: 10.0),
        Center(child: _buildActionButton("Continue?")),
      ],
    );
  }

  Widget _buildAddedText(String addedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Book not started",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Added: $addedDate"),
        ),
        Center(child: _buildActionButton("Started?")),
      ],
    );
  }

  Widget _buildStartedText(String startDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Book started",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Started: $startDate"),
        ),
        const SizedBox(height: 10.0),
        Center(child: _buildActionButton("Finished?")),
      ],
    );
  }

  Widget _buildActionButton(String text) {
    return CustomElevatedButton(
      onPressed: () {
        if (text == "Finished?") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StepperPage(bookEntry: userData),
              ));
        } else {
          _openContinueDialog(context);
        }
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

  Future<void> _openContinueDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'How are you enjoying the book?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: IntrinsicHeight(
            child: Column(
              children: [
                _buildOptionButton(
                  context,
                  'Reading',
                  Icons.book,
                  BookStatus.reading,
                ),
                const SizedBox(height: 12),
                _buildOptionButton(
                  context,
                  'Listening',
                  Icons.headphones,
                  BookStatus.listening,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    String label,
    IconData icon,
    BookStatus status,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            userData.status = status;
            IsarService().updateUserDataEntry(userData);
          });
          Navigator.pop(context);
        },
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return finalNote!.rating < 6
        ? RatingBar(
            minRating: 1,
            maxRating: 5,
            initialRating: finalNote!.rating.toDouble(),
            ignoreGestures: true,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: Colors.amber),
              half: const Icon(Icons.star_half, color: Colors.amber),
              empty: const Icon(Icons.star_border),
            ),
            allowHalfRating: false,
            itemSize: 20,
            onRatingUpdate: (_) {},
          )
        : Chip(
            label: const Text(
              "Lifechanging",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.blue[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
