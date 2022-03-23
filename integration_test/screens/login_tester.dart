import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base/base_screen_tester.dart';

/// LoginScreen
class LoginTester extends BaseScreenTester {
  const LoginTester(WidgetTester tester) : super(tester);

  /// Ввод пароля
  Future<void> enterPassword(String password) async {
    final fieldFinder = find.byType(TextField);

    expect(fieldFinder, findsOneWidget);
    await addDelay(1000);
    tester.printToConsole('👉🏻 Введен пароль: $password');
    await tester.enterText(fieldFinder, password);
    await tester.pumpAndSettle();
  }
}
