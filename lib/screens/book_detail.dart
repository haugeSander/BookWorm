import 'dart:io';
import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  late final UserBookEntry userData;
  late final FinishedBookNote? finalNote;
  late final Color color;
  late final bool isFinished;

  BookDetailPage({super.key, required this.book}) {
    userData = book.userDataReference.value!;
    isFinished = userData.status == BookStatus.finished;
    finalNote = userData.finishedNote.value;
    color = _getCorrespondingColor(userData.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [_buildTagSection(), _buildCardView()],
                ),
              ),
            ),
          ),
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
      onPressed: () {},
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
                    half: const Icon(Icons.star_half),
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
