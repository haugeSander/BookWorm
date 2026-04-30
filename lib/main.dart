import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/screens/library.dart';
import 'package:book_worm/screens/onboarding_page.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const _OnboardingGate(),
    );
  }
}

class _OnboardingGate extends StatelessWidget {
  const _OnboardingGate();

  static const _seenKey = 'hasSeenOnboarding';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasSeenOnboarding(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return const LibraryPage();
        }

        return OnboardingPage(
          onGetStarted: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool(_seenKey, true);
            if (!context.mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LibraryPage()),
            );
          },
        );
      },
    );
  }

  Future<bool> _hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenKey) ?? false;
  }
}
