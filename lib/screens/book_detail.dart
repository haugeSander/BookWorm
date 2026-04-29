import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:book_worm/widgets/book_details/book_detail_header.dart';
import 'package:book_worm/widgets/book_details/book_detail_user_card.dart';
import 'package:book_worm/widgets/book_details/book_detail_widget_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
        return Scaffold(
          extendBodyBehindAppBar: !state.isEditMode,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:
                state.isEditMode ? AppTheme.surface : Colors.transparent,
            elevation: state.isEditMode ? null : 0,
            scrolledUnderElevation: state.isEditMode ? null : 0,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: state.isEditMode
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            title: state.isEditMode ? const Text(AppStrings.editBook) : null,
            actions: [
              if (state.isEditMode) ...[
                TextButton(
                  onPressed: state.discardChanges,
                  child: const Text(AppStrings.cancel),
                ),
                TextButton(
                  onPressed: () async {
                    await state.saveChanges();
                  },
                  child: const Text(AppStrings.save),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Material(
                    color: Colors.black54,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      ),
                      tooltip: AppStrings.editBook,
                      onPressed: state.toggleEditMode,
                    ),
                  ),
                ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: BookDetailHeader()),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
                sliver: SliverToBoxAdapter(child: BookDetailUserCard()),
              ),
              const SliverToBoxAdapter(child: BookDetailWidgetSections()),
            ],
          ),
        );
      },
    );
  }
}
