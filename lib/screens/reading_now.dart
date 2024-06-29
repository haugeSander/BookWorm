import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_worm/models/book.dart';

import '../services/isar_service.dart';

class ReadingNowPage extends StatelessWidget {
  ReadingNowPage({super.key});

  List<Book> books = [];

  Stream<List<Book>> _getInitialInfo() async* {
    IsarService().getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          StreamBuilder<List<Book>>(
              stream: IsarService().getAllBooks(),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No books found'));
                } else {
                  return _bookList(snapshot.data!);
                }
              })),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future openAddDialog(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Fedda liker gutter!'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter why'),
            ),
            actions: [
              TextButton(
                  child: Text('SUBMIT'),
                  onPressed: () {
                    submit(context);
                  })
            ],
          ));

  void submit(context) {
    Navigator.of(context).pop();
  }

  Column _bookList(List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Popular',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ListView.separated(
            itemCount: books.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
                  height: 25,
                ),
            padding: EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            books[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Text(
                            books[index].author,
                            style: const TextStyle(
                                color: Color(0xff7B6F72),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/button.svg',
                          width: 30,
                          height: 30,
                        ),
                      )
                    ]),
              );
            })
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Reading now',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
