import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BookSummary extends StatefulWidget {
  const BookSummary({super.key});

  @override
  _BookSummaryState createState() => _BookSummaryState();
}

class _BookSummaryState extends State<BookSummary> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
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
                setState(() {
                  _currentPage = page ~/ 2; // Integer division by 2
                });
              },
              children: [
                _buildCoverPage(),
                _buildChapterOnePage(),
                _buildChapterTwoPage(),
                _buildChapterThreePage(),
                _buildChapterFourPage(),
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
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book worm',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'by Sander H.',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'A book enthusiast on a journey through countless pages, always eager to learn and explore new worlds.',
            style: TextStyle(fontSize: 14),
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
          FutureBuilder<Map<String, dynamic>>(
            future: _getStatistics(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              } else {
                final stats = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total books: ${stats['totalBooks']}'),
                    Text('Books in progress: ${stats['booksInProgress']}'),
                    Text('Finished books: ${stats['finishedBooks']}'),
                    Text(
                        'Average rating: ${stats['averageRating'].toStringAsFixed(1)}'),
                  ],
                );
              }
            },
          ),
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
            'Your reading habits',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          Text('Add more statistics or information here'),
        ],
      ),
    );
  }

  Widget _buildChapterThreePage() {
    return _buildPageContainer(
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chapter 3',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Your favorite genres',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          Text('Add genre statistics or information here'),
        ],
      ),
    );
  }

  Widget _buildChapterFourPage() {
    return _buildPageContainer(
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chapter 4',
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

  Future<Map<String, dynamic>> _getStatistics() async {
    return {
      'totalBooks': 1,
      'booksInProgress': 2,
      'finishedBooks': 2,
      'averageRating': 4,
    };
  }
}
