import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class BaseScreenTester {
  final WidgetTester tester;

  const BaseScreenTester(this.tester);

  Future<void> addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }

  void printFinder(Finder finder) {
    tester.printToConsole('👉🏻 🔎 Finder: $finder');
  }

  Future<void> checkScreenOpenedByKey(ValueKey<String> warmingUpKey) async {
    await addDelay(1000);
    expect(find.byKey(warmingUpKey), findsOneWidget);
    tester.printToConsole('👉🏻 Screen opened: ${warmingUpKey.value}');
  }

  Future<void> checkScreenOpenedByString(String text) async {
    await addDelay(1000);
    final finder = find.text(text);
    printFinder(finder);

    expect(find.text(text), findsWidgets);
    tester.printToConsole('👉🏻 Screen opened: $text');
    await addDelay(1000);
  }

  Future<void> tapButton(ValueKey<String> btnKey) async {
    final btnFinder = find.byKey(btnKey);
    printFinder(btnFinder);

    expect(btnFinder, findsOneWidget);
    await addDelay(1000);
    tester.printToConsole('👉🏻 Тап по ${btnKey.value}');
    await tester.tap(btnFinder);
    await tester.pumpAndSettle();
  }
}
