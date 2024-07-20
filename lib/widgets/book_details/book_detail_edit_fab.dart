import 'package:book_worm/states/book_detail_state.dart';
import 'package:flutter/material.dart';

class EditModeButton extends StatelessWidget {
  final BookDetailState state;

  const EditModeButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return state.isEditMode
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: state.discardChanges,
                backgroundColor: Colors.red,
                child: const Icon(Icons.close),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: state.saveChanges,
                backgroundColor: Colors.green,
                child: const Icon(Icons.check),
              ),
            ],
          )
        : FloatingActionButton(
            onPressed: state.toggleEditMode,
            child: const Icon(Icons.edit),
          );
  }
}
