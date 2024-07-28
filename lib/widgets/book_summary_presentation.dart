import 'package:book_worm/models/user.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BookSummary extends StatefulWidget {
  const BookSummary({super.key});

  @override
  _BookSummaryState createState() => _BookSummaryState();
}

class _BookSummaryState extends State<BookSummary> {
  late PageController _pageController;
  User? user;
  List<UserBookEntry>? userData;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user = await IsarService().getUser();
      userData = await IsarService().getAllUserData();
      setState(() {});
    });

    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 300, // Increased height for better visibility
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {});
              },
              children: [
                _buildCoverPage(),
                _buildChapterOnePage(),
                _buildChapterTwoPage(),
                _buildBackCoverPage(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: _pageController,
            count: 3, // Number of page pairs
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8DC),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildCoverPage() {
    return _buildPageContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book worm',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'by ${user != null ? user!.firstName : "Unknown"}',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user != null && user!.biography != null
                ? user!.biography!
                : 'Unknowing book expert and lover...',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterOnePage() {
    return _buildPageContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chapter 1',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Your statistics',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Builder(builder: (context) {
            var statistics = _getStatistics();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total books: ${statistics['totalBooks']}'),
                Text('Books in progress: ${statistics['booksInProgress']}'),
                Text('Finished books: ${statistics['finishedBooks']}'),
                Text(
                    'Average rating: ${statistics['averageRating'].toStringAsFixed(1)}'),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChapterTwoPage() {
    return _buildPageContainer(
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chapter 2',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Your reading goals',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          Text('Add reading goals or achievements here'),
        ],
      ),
    );
  }

  Widget _buildBackCoverPage() {
    return _buildPageContainer(
      const Center(
        child: Text(
          'Thank you for reading!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatistics() {
    if (userData != null) {
      double averageRating = 0;
      int finishedBooks = 0;
      int booksInProgress = 0;

      for (var entry in userData!) {
        if (entry.finishedNote.value != null &&
            entry.status == BookStatus.finished) {
          averageRating += entry.finishedNote.value!.rating;
          finishedBooks++;
        } else if (entry.status == BookStatus.reading ||
            entry.status == BookStatus.listening) {
          booksInProgress++;
        }
      }
      averageRating = averageRating / finishedBooks;

      return {
        'totalBooks': userData!.length,
        'booksInProgress': booksInProgress,
        'finishedBooks': finishedBooks.toInt(),
        'averageRating': averageRating,
      };
    } else {
      return {
        'totalBooks': 0,
        'booksInProgress': 0,
        'finishedBooks': 0,
        'averageRating': 0,
      };
    }
  }
}
