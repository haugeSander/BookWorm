import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailTag extends StatelessWidget {
  const BookDetailTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _buildChips(context, state),
          ),
        );
      },
    );
  }

  List<Widget> _buildChips(BuildContext context, BookDetailState state) {
    List<Widget> chips = [];
    var userData = state.userData;
    var finishedNote = userData.finishedNote.value;

    // Add the status chip
    chips.add(_buildChip(
      userData.status.name,
      state.getStatusColor(),
      isStatus: true,
    ));

    // Add tag chips if finishedNote is not null and has tags
    if (finishedNote != null && finishedNote.tags.isNotEmpty) {
      chips.addAll(finishedNote.tags.map((tag) => _buildChip(
            tag,
            _getColorForTag(tag),
            onDeleted: state.isEditMode ? () => state.removeTag(tag) : null,
          )));
    }

    // Add the "add tag" button in edit mode
    if (state.isEditMode) {
      chips.add(
        ActionChip(
          label: const Icon(Icons.add),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () => _addNewTag(context, state),
        ),
      );
    }

    return chips;
  }

  Widget _buildChip(String label, Color backgroundColor,
      {VoidCallback? onDeleted, bool isStatus = false}) {
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
      onDeleted: isStatus ? null : onDeleted,
      deleteIconColor: textColor,
    );
  }

  void _addNewTag(BuildContext context, BookDetailState state) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => _buildAddTagDialog(context),
    );
    if (result != null && result.isNotEmpty) {
      state.addTag(result);
    }
  }

  Widget _buildAddTagDialog(BuildContext context) {
    final controller = TextEditingController();
    return AlertDialog(
      title: const Text('Add a new tag'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: "Enter tag name"),
        textCapitalization: TextCapitalization.words,
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () => Navigator.of(context).pop(controller.text),
        ),
      ],
    );
  }

  Color _getColorForTag(String tag) {
    final hash = tag.hashCode;
    final hue = (hash % 360).toDouble();
    return HSLColor.fromAHSL(1.0, hue, 0.7, 0.5).toColor();
  }

  Color _getContrastingTextColor(Color backgroundColor) {
    double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
