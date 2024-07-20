import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/stepper_page.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/string.dart';
import 'package:book_worm/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookDetailUserCard extends StatelessWidget {
  const BookDetailUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
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
                        child: _buildCardViewText(context, state),
                      ),
                      Expanded(
                        flex: 2,
                        child: state.getStatusIcon(),
                      ),
                    ],
                  ),
                  if (state.userData.status == BookStatus.finished)
                    _buildRatingSection(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardViewText(BuildContext context, BookDetailState state) {
    final dateFormat = DateFormat('MMM d, y');
    final formattedCurrentStatusDate =
        state.userData.dateOfCurrentStatus != null
            ? dateFormat.format(state.userData.dateOfCurrentStatus!)
            : "";
    final formattedStartDate = state.userData.timeStarted != null
        ? dateFormat.format(state.userData.timeStarted!)
        : "";

    switch (state.userData.status) {
      case BookStatus.finished:
        return _buildFinishedText(context, state, formattedStartDate);
      case BookStatus.dropped:
        return _buildDroppedText(context, state, formattedCurrentStatusDate);
      case BookStatus.added:
        return _buildAddedText(context, state, formattedCurrentStatusDate);
      default:
        return _buildStartedText(context, state, formattedCurrentStatusDate);
    }
  }

  Widget _buildFinishedText(
      BuildContext context, BookDetailState state, String startDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: state.isEditMode
              ? TextButton(
                  onPressed: () => _openStatusChangeDialog(context, state),
                  child: const Text(
                    "Book finished",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                )
              : const Text(
                  "Book finished",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
        ),
        const SizedBox(height: 10.0),
        _buildDateRow(
            context, state, "Started", startDate, state.userData.timeStarted),
        if (state.finalNote != null)
          _buildDateRow(
            context,
            state,
            "Finished",
            DateFormat('MMMM d, y').format(state.finalNote!.timeEnded),
            state.finalNote!.timeEnded,
          ),
      ],
    );
  }

  Widget _buildDroppedText(
      BuildContext context, BookDetailState state, String stopDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: state.isEditMode
              ? TextButton(
                  onPressed: () => _openStatusChangeDialog(context, state),
                  child: const Text(
                    "Book dropped",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                )
              : const Text(
                  "Book dropped",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
        ),
        const SizedBox(height: 10.0),
        _buildDateRow(context, state, "Stopped", stopDate,
            state.userData.dateOfCurrentStatus),
        const SizedBox(height: 10.0),
        Center(child: _buildActionButton(context, state, "Continue?")),
      ],
    );
  }

  Widget _buildAddedText(
      BuildContext context, BookDetailState state, String addedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: state.isEditMode
              ? TextButton(
                  onPressed: () => _openStatusChangeDialog(context, state),
                  child: const Text(
                    "Book not started",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                )
              : const Text(
                  "Book not started",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
        ),
        _buildDateRow(context, state, "Added", addedDate,
            state.userData.dateOfCurrentStatus),
        Center(child: _buildActionButton(context, state, "Started?")),
      ],
    );
  }

  Widget _buildStartedText(
      BuildContext context, BookDetailState state, String startDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: state.isEditMode
              ? TextButton(
                  onPressed: () => _openStatusChangeDialog(context, state),
                  child: const Text(
                    "Book started",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                )
              : const Text(
                  "Book started",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
        ),
        const SizedBox(height: 10.0),
        _buildDateRow(context, state, "Started", startDate,
            state.userData.dateOfCurrentStatus),
        const SizedBox(height: 10.0),
        Center(child: _buildActionButton(context, state, "Finished?")),
      ],
    );
  }

  Widget _buildDateRow(BuildContext context, BookDetailState state,
      String label, String date, DateTime? initialDate) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: state.isEditMode
          ? TextButton(
              onPressed: () =>
                  _openDatePicker(context, state, initialDate, label),
              child: Text("$label: $date"),
            )
          : Text("$label: $date"),
    );
  }

  void _openStatusChangeDialog(BuildContext context, BookDetailState state) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Book Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: BookStatus.values.map((status) {
              return ListTile(
                title: Text(status.name.capitalize()),
                onTap: () {
                  state.updateBookStatus(status);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _openDatePicker(BuildContext context, BookDetailState state,
      DateTime? initialDate, String dateType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      state.updateDate(dateType, picked);
    }
  }

  Widget _buildActionButton(
      BuildContext context, BookDetailState state, String text) {
    return CustomElevatedButton(
      onPressed: () {
        if (text == "Finished?") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StepperPage(bookEntry: state.userData),
            ),
          );
        } else {
          _openContinueDialog(context, state);
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

  Future<void> _openContinueDialog(
      BuildContext context, BookDetailState state) {
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
                    context, state, 'Reading', Icons.book, BookStatus.reading),
                const SizedBox(height: 12),
                _buildOptionButton(context, state, 'Listening',
                    Icons.headphones, BookStatus.listening),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    BookDetailState state,
    String label,
    IconData icon,
    BookStatus status,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          state.updateBookStatus(status);
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

  Widget _buildRatingSection(BookDetailState state) {
    return Row(
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
        if (state.finalNote != null) _buildRatingBar(state),
      ],
    );
  }

  Widget _buildRatingBar(BookDetailState state) {
    return state.finalNote!.rating < 6
        ? RatingBar(
            minRating: 1,
            maxRating: 5,
            initialRating: state.finalNote!.rating.toDouble(),
            ignoreGestures: !state.isEditMode,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: Colors.amber),
              half: const Icon(Icons.star_half, color: Colors.amber),
              empty: const Icon(Icons.star_border),
            ),
            allowHalfRating: false,
            itemSize: 20,
            onRatingUpdate: (rating) => state.updateRating(rating.toInt()),
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
}
