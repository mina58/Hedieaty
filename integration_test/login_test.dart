import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedieaty/screens/HomeScreen.dart';
import 'package:hedieaty/widgets/HomeSearchRow.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hedieaty/main.dart' as app;
import 'dart:math';

Future<void> pumpUntilFound(
    WidgetTester tester,
    Finder finder, {
      Duration timeout = const Duration(seconds: 10),
      Duration interval = const Duration(milliseconds: 100),
    }) async {
  final endTime = DateTime.now().add(timeout);

  while (DateTime.now().isBefore(endTime)) {
    await tester.pumpAndSettle(interval);
    if (tester.any(finder)) {
      return;
    }
  }

  throw Exception('Widget with finder $finder not found within $timeout');
}

String generateRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
          (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}

String generateRandomPhone() {
  final random = Random();
  return '123${random.nextInt(10000000).toString().padLeft(7, '0')}';
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Test', () {
    testWidgets('Login Flow Test', (tester) async {
      final email = "m@x.com";
      final password = "123456";
      // Launch the app
      app.main();
      await tester.pumpAndSettle();
      await pumpUntilFound(tester, find.byKey(const Key('login_button')));

      // Fill in login credentials
      await tester.enterText(find.byKey(const Key('login_email_field')), email);
      await tester.enterText(find.byKey(const Key('login_password_field')), password);

      // Submit login form
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Verify navigation to Home Screen by checking for HomeSearchRow
      await pumpUntilFound(tester, find.byKey(Key("home_search_row")));
      expect(find.byKey(Key("home_search_row")), findsOneWidget);
    });
  });
}
