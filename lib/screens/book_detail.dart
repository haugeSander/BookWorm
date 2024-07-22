import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/widgets/book_details/book_detail_edit_fab.dart';
import 'package:book_worm/widgets/book_details/book_detail_findings.dart';
import 'package:book_worm/widgets/book_details/book_detail_gallery.dart';
import 'package:book_worm/widgets/book_details/book_detail_header.dart';
import 'package:book_worm/widgets/book_details/book_detail_notes.dart';
import 'package:book_worm/widgets/book_details/book_detail_summary.dart';
import 'package:book_worm/widgets/book_details/book_detail_tags.dart';
import 'package:book_worm/widgets/book_details/book_detail_user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
        return Scaffold(
          body: const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: BookDetailHeader()),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverToBoxAdapter(child: BookDetailTag()),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverToBoxAdapter(child: BookDetailUserCard()),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverToBoxAdapter(child: BookDetailSummary()),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverToBoxAdapter(child: BookDetailFindings()),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverToBoxAdapter(child: BookDetailGallery()),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 8.0, bottom: 55),
                sliver: SliverToBoxAdapter(child: BookDetailNotes()),
              ),
            ],
          ),
          floatingActionButton: EditModeButton(state: state),
        );
      },
    );
  }
}
