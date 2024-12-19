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

  group('Signup Flow Test', () {
    testWidgets('Signup Flow Test', (tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();
      await pumpUntilFound(
          tester, find.byKey(const Key('signup_navigation_button')));

      // Generate random inputs
      final username = generateRandomString(8);
      final email = '${generateRandomString(5)}@example.com';
      final phone = generateRandomPhone();
      final password = 'password123';

      // Navigate to Signup Screen
      await tester.tap(find.byKey(const Key('signup_navigation_button')));
      await tester.pumpAndSettle();

      // Fill in signup details
      await tester.enterText(
          find.byKey(const Key('signup_username_field')), username);
      await tester.enterText(
          find.byKey(const Key('signup_email_field')), email);
      await tester.enterText(
          find.byKey(const Key('signup_password_field')), password);
      await tester.enterText(
          find.byKey(const Key('signup_phone_field')), phone);
      await tester.pumpAndSettle(); // Wait for the UI to settle

      // Ensure the signup button is visible
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(); // Wait for UI to settle
      await tester.ensureVisible(find.byKey(const Key('signup_button')));
      await tester.pumpAndSettle();

      // Submit signup form
      await tester.tap(find.byKey(const Key('signup_button')));
      await tester.pumpAndSettle();

      await pumpUntilFound(tester, find.byKey(Key("home_search_row")));
      // Verify navigation to Home Screen by checking for HomeSearchRow
      expect(find.byKey(Key("home_search_row")), findsOneWidget);
    });
  });
}
