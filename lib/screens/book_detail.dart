import 'dart:io';
import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/library.dart';
import 'package:book_worm/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  late UserBookEntry userData;
  late FinishedBookNote? finalNote;
  late Color color;
  bool isFinished = false;

  BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    userData = book.userDataReference.value!;
    isFinished = userData.status == BookStatus.finished;
    finalNote = userData.finishedNote.value;
    color = _getCorrespondingColor(userData);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          const SizedBox(height: 16.0),
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Column(
              children: [_tagSection(), _cardView()],
            ),
          ))
        ],
      ),
    );
  }

  Card _cardView() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(children: [
          Expanded(
            flex: 3,
            child: _cardViewText,
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: _ratingBar,
            ),
          ),
        ]),
      ),
    );
  }

  Widget get _cardViewText {
    switch (userData.status) {
      case BookStatus.finished:
        return Column(children: [
          const Text(
            "Book finished",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
              "Started: ${userData.dateOfCurrentStatus != null ? DateFormat('MMMM d, y').format(userData.dateOfCurrentStatus!) : ""}"),
          if (finalNote != null && isFinished)
            Column(
              children: [
                Text(
                    "Finished: ${DateFormat('MMMM d, y').format(finalNote!.timeEnded)}"),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Score given',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
        ]);
      case BookStatus.dropped:
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
            const SizedBox(
              height: 10.0,
            ),
            Text(
                "Stopped: ${userData.dateOfCurrentStatus != null ? DateFormat('MMMM d, y').format(userData.dateOfCurrentStatus!) : ""}"),
            const SizedBox(
              height: 10.0,
            ),
            CustomElevatedButton(
              onPressed: () {},
              borderRadius: BorderRadius.circular(20),
              child: const Text(
                "Continue?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        );
      case BookStatus.added:
        return Column(
          children: [
            const Text("Book not started",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
            Text(
                "Added: ${userData.dateOfCurrentStatus != null ? DateFormat('MMMM d, y').format(userData.dateOfCurrentStatus!) : ""}"),
            CustomElevatedButton(
              onPressed: () {},
              borderRadius: BorderRadius.circular(20),
              child: const Text(
                "Started?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        );
      default:
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
            const SizedBox(
              height: 10.0,
            ),
            Text(
                "Started: ${userData.dateOfCurrentStatus != null ? DateFormat('MMMM d, y').format(userData.dateOfCurrentStatus!) : ""}"),
            const SizedBox(
              height: 10.0,
            ),
            CustomElevatedButton(
              onPressed: () {},
              borderRadius: BorderRadius.circular(20),
              child: const Text(
                "Finished?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        );
    }
  }

  List<Widget> get _ratingBar {
    return [
      _getCorrespondingIcon(userData),
      if (userData.status == BookStatus.finished && finalNote != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: finalNote!.rating < 6
              ? RatingBar(
                  minRating: 1,
                  maxRating: 5,
                  initialRating: 2,
                  ignoreGestures: true,
                  ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      half: const Icon(Icons.star_half),
                      empty: const Icon(Icons.star_border)),
                  allowHalfRating: false,
                  itemSize: 20,
                  onRatingUpdate: (double value) {},
                )
              : const Chip(
                  label: Text("Life-changing"),
                  backgroundColor: Colors.teal,
                ),
        )
    ];
  }

  Row _tagSection() {
    return Row(
      children: [
        Chip(
          label: Text(
            userData.status.name,
            style: const TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: color),
          ),
          backgroundColor: color,
        ),
      ],
    );
  }

  Stack _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(book.coverImage)), fit: BoxFit.cover)),
        ),
        // Overlay card with title, author and back button
        Positioned(
          top: 30,
          left: 8,
          right: 8,
          child: Card(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        Text(
                          book.author,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Color _getCorrespondingColor(UserBookEntry book) {
    switch (book.status) {
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

  Widget _getCorrespondingIcon(UserBookEntry book) {
    switch (book.status) {
      case BookStatus.finished:
        return SvgPicture.asset("assets/icons/finished_medal.svg",
            width: 75.0, height: 75.0);
      case BookStatus.reading:
        return SvgPicture.asset("assets/icons/reading_icon.svg",
            width: 75.0, height: 75.0);
      case BookStatus.listening:
        return const Icon(
          Icons.headphones,
          size: 75,
        );
      case BookStatus.dropped:
        return const Icon(
          Icons.block_outlined,
          size: 75,
        );
      case BookStatus.added:
        return SvgPicture.asset("assets/icons/added_icon.svg",
            width: 75.0, height: 75.0);
    }
  }
}
