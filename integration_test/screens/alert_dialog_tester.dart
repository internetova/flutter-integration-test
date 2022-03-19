import 'package:flutter/cupertino.dart';
import 'package:flutter_integration_test/utils/warming_up_keys.dart';
import 'package:flutter_test/flutter_test.dart';

/// AlertDialog
class AlertDialogTester {
  final WidgetTester tester;

  AlertDialogTester(this.tester);

  Future<void> checkAlertOpened() async {
    expect(find.byKey(WarmingUpKeys.alert), findsOneWidget);
    tester.printToConsole('👉🏻 AlertDialog opens');
  }

  Future<void> checkAlertClosed() async {
    expect(find.byKey(WarmingUpKeys.alert), findsNothing);
    tester.printToConsole('👉🏻 AlertDialog closed');
  }

  Future<void> tapToAlertButton(ValueKey<String> name) async {
    final btnFinder = find.byKey(name);

    expect(btnFinder, findsOneWidget);
    await tester.tap(btnFinder);
    await tester.pumpAndSettle();
    tester.printToConsole('👉🏻 Тап по ${name.value}');
    await _addDelay(1000);
  }

  Future<void> _addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }
}
