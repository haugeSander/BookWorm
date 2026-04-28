import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/screens/library.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  final db = AppDatabase();
  runApp(
    Provider<DatabaseService>(
      create: (_) => DatabaseService(db),
      dispose: (_, svc) => db.close(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LibraryPage(),
    );
  }
}
