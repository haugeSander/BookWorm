import 'package:book_worm/models/user.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/screens/settings_pages/edit_goals.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.blue[100]!],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/book_worm_logo.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Book Worm',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'by ${user != null ? user!.firstName : "Unknown"}',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                user != null && user!.biography != null
                    ? user!.biography!
                    : 'Unknowing book expert and lover...',
                style: TextStyle(fontSize: 14, color: Colors.blue[800]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterOnePage() {
    return _buildPageContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chapter 1: Your Reading Journey',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Builder(builder: (context) {
            var statistics = _getStatistics();
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildCompactStatCard(
                  icon: Icons.book,
                  title: 'Total',
                  value: statistics['totalBooks'].toString(),
                  color: Colors.blue,
                ),
                _buildCompactStatCard(
                  icon: Icons.hourglass_empty,
                  title: 'In Progress',
                  value: statistics['booksInProgress'].toString(),
                  color: Colors.orange,
                ),
                _buildCompactStatCard(
                  icon: Icons.check_circle,
                  title: 'Finished',
                  value: statistics['finishedBooks'].toString(),
                  color: Colors.green,
                ),
                _buildCompactStatCard(
                  icon: Icons.star,
                  title: 'Avg. Rating',
                  value: statistics['averageRating'].toStringAsFixed(1),
                  color: Colors.purple,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCompactStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChapterTwoPage() {
    Map<String, dynamic> stats = _getStatistics();

    int readingGoal = user?.readingGoal ?? 0;
    DateTime? achieveBy = user?.achieveBy;

    // Calculate progress
    double progress =
        readingGoal > 0 ? stats['finishedBooks'] / readingGoal : 0;
    progress = progress.clamp(0.0, 1.0);

    // Calculate days remaining
    int daysRemaining = 0;
    if (achieveBy != null) {
      daysRemaining = achieveBy.difference(DateTime.now()).inDays;
      daysRemaining = daysRemaining < 0 ? 0 : daysRemaining;
    }

    return _buildPageContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chapter 2: Reading Goals',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress == 1.0
                        ? Colors.green
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            children: [
              _buildCompactInfoChip(
                icon: Icons.book,
                label: '${stats['finishedBooks']} / $readingGoal books',
              ),
              _buildCompactInfoChip(
                icon: Icons.calendar_today,
                label: achieveBy != null
                    ? '$daysRemaining days left'
                    : 'No deadline',
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditGoals()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
            ),
            child: const Text('Edit Goals'),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactInfoChip(
      {required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[800])),
      ],
    );
  }

  Widget _buildBackCoverPage() {
    return _buildPageContainer(
      Container(
        decoration: BoxDecoration(
          color: Colors.brown[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.brown[200]!),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Thank you for reading!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your literary journey awaits',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('MMMM d, y').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.book,
                    size: 40,
                    color: Colors.brown[400],
                  ),
                ],
              ),
            ),
          ],
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
