import 'package:book_worm/services/isar_service.dart';
import 'package:book_worm/utility/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:book_worm/models/user_book_entry.dart';

class StepperPage extends StatefulWidget {
  final UserBookEntry bookEntry;

  const StepperPage({super.key, required this.bookEntry});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  late UserBookEntry bookEntry;
  late Book book;
  late DateTime dateFinished;
  late List<TextEditingController> controllers;
  List<String> tags = [];
  int bookScore = 0;
  bool showRatingBar = true;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    bookEntry = widget.bookEntry;
    book = bookEntry.bookReference.value!;
    dateFinished = DateTime.now();
    controllers = List.generate(9, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stepper(
        type: StepperType.vertical,
        steps: _getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == _getSteps().length - 1;
          if (isLastStep) {
            _handleSubmit();
          } else {
            setState(() => currentStep++);
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() => currentStep--);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  List<Step> _getSteps() => [
        _buildBaseInfoStep(),
        _buildDetailedStep(),
        _buildFinishingUpStep(),
        _buildReviewStep(),
      ];

  Step _buildBaseInfoStep() {
    return Step(
      isActive: currentStep >= 0,
      title: const Text("Base information"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good job on completing ${book.title.capitalize()}!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            "Please fill in the requested information in the following sections.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _buildDatePicker(),
          const SizedBox(height: 16),
          Text(
            "Explain the book in 3 sentences",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < 3; i++) ...[
            _buildInputField("Sentence ${i + 1}", controllers[i]),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Step _buildDetailedStep() {
    return Step(
      isActive: currentStep >= 1,
      title: const Text("Detailed"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What impressions did it leave you with?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _buildInputField("", controllers[3]),
          const SizedBox(height: 16),
          Text(
            "Who should read it?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _buildInputField("", controllers[4]),
          const SizedBox(height: 16),
          Text(
            "Did the book change you, if so, how?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _buildInputField("", controllers[5]),
        ],
      ),
    );
  }

  Step _buildFinishingUpStep() {
    return Step(
      isActive: currentStep >= 2,
      title: const Text("Finishing up"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "From this book, what are your 3 favorite quotes?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          for (int i = 6; i < 9; i++) ...[
            _buildInputField("Quote ${i - 5}", controllers[i]),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 16),
          Text(
            "Add tags to this book",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _buildTagInput(),
          const SizedBox(height: 16),
          Text(
            "Score",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _buildRatingBar(),
        ],
      ),
    );
  }

  Step _buildReviewStep() {
    return Step(
      isActive: currentStep >= 3,
      title: const Text("Review"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review your entries",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < controllers.length; i++) ...[
            Text(
              "Entry ${i + 1}:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(controllers[i].text),
            const SizedBox(height: 8),
          ],
          Text(
            "Tags: ${tags.join(', ')}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Score: $bookScore",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: dateFinished,
          firstDate: DateTime(2017, 9, 7),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != dateFinished) {
          setState(() {
            dateFinished = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date Finished',
          border: OutlineInputBorder(),
        ),
        child: Text(
          "${dateFinished.toLocal()}".split(' ')[0],
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildTagInput() {
    return Wrap(
      spacing: 8.0,
      children: [
        ...tags.map((tag) => Chip(
              label: Text(tag),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onDeleted: () {
                setState(() {
                  tags.remove(tag);
                });
              },
            )),
        ActionChip(
          label: const Icon(Icons.add),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () async {
            final result = await showDialog<String>(
              context: context,
              builder: (context) => _buildAddTagDialog(),
            );
            if (result != null && result.isNotEmpty) {
              setState(() {
                tags.add(result);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildAddTagDialog() {
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

  Widget _buildRatingBar() {
    return Center(
      child: Column(
        children: [
          showRatingBar
              ? RatingBar(
                  initialRating: bookScore.toDouble(),
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.amber),
                    half: const Icon(Icons.star_half, color: Colors.amber),
                    empty: const Icon(Icons.star_border, color: Colors.amber),
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      bookScore = rating.toInt();
                    });
                  },
                )
              : Text(
                  "Lifechanging indeed!",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              showRatingBar ? "or maybe it was" : "or maybe it wasn't",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showRatingBar = !showRatingBar;
                showRatingBar ? bookScore = 0 : bookScore = 6;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[200], // background
              foregroundColor: Colors.white, // foreground
            ),
            child: Text(
              showRatingBar ? 'Lifechanging' : 'Lifechanging!',
              style: TextStyle(
                  fontWeight:
                      showRatingBar ? FontWeight.w300 : FontWeight.w800),
            ),
          ),
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Final note for ${book.title.capitalize()}',
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _handleSubmit() {
    List<String> inThreeSentences = List.empty(growable: true);
    inThreeSentences.add(controllers[0].value.text);
    inThreeSentences.add(controllers[1].value.text);
    inThreeSentences.add(controllers[2].value.text);
    List<String> quoteList = List.empty(growable: true);
    quoteList.add(controllers[6].value.text);
    quoteList.add(controllers[7].value.text);
    quoteList.add(controllers[8].value.text);

    // Create a FinishedBookNote object
    final note = FinishedBookNote(
      bookId: book.bookId,
      timeEnded: dateFinished,
      inThreeSentences: inThreeSentences,
      impressions: controllers[3].text,
      whoShouldRead: controllers[4].text,
      howChangedMe: controllers[5].text,
      topThreeQuotes: quoteList,
      tags: tags,
      rating: bookScore,
    );
    bookEntry.finishedNote.value = note;
    note.bookDataReference.value = bookEntry;
    bookEntry.status = BookStatus.finished;
    IsarService().saveFinalBookNote(note);
    IsarService().updateUserDataEntry(bookEntry);

    // Navigate back to the previous screen
    Navigator.pop(context, note);
  }
}
