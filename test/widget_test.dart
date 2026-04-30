import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/main.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows the library shell', (tester) async {
    SharedPreferences.setMockInitialValues({'hasSeenOnboarding': true});
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      Provider<DatabaseService>(
        create: (_) => DatabaseService(db),
        dispose: (_, __) => db.close(),
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.searchHint), findsOneWidget);
    expect(find.text(AppStrings.addBook), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
