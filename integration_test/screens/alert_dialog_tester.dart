import 'package:flutter/cupertino.dart';
import 'package:flutter_integration_test/utils/warming_up_keys.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base/base_screen_tester.dart';

/// AlertDialog
class AlertDialogTester extends BaseScreenTester {
  AlertDialogTester(WidgetTester tester) : super(tester);

  Future<void> checkAlert({bool isOpened = true}) async {
    tester.printToConsole('ππ» START checkAlert');

    final alertFinder = find.byKey(WarmingUpKeys.alert);
    printFinder(alertFinder);

    if (isOpened) {
      expect(alertFinder, findsOneWidget);
      tester.printToConsole('ππ» AlertDialog: opened');
    } else {
      expect(alertFinder, findsNothing);
      tester.printToConsole('ππ» AlertDialog: closed');
    }

    tester.printToConsole('ππ» END checkAlert');
  }

  Future<void> tapToAlertButton(ValueKey<String> name) async {
    final btnFinder = find.byKey(name);

    expect(btnFinder, findsOneWidget);
    await addDelay(1000);
    tester.printToConsole('ππ» Π’Π°ΠΏ ΠΏΠΎ ${name.value}');
    await tester.tap(btnFinder);
    await tester.pumpAndSettle();
  }
}
