import 'package:flutter/material.dart';
import 'package:flutter_integration_test/utils/warming_up_keys.dart';
import 'package:flutter_test/flutter_test.dart';

/// LoginScreen
class LoginTester {
  final WidgetTester tester;

  const LoginTester(this.tester);

  Future<void> checkLoginScreenOpened() async {
    final titleFinder = find.byKey(WarmingUpKeys.appBarTitleLoginKey);

    expect(titleFinder, findsOneWidget);
    tester.printToConsole('👉🏻 LoginScreen screen opens');
  }

  /// Ввод пароля
  Future<void> enterPassword(String password) async {
    final fieldFinder = find.byType(TextField);

    expect(fieldFinder, findsOneWidget);
    await tester.enterText(fieldFinder, password);
    await tester.pumpAndSettle();
    tester.printToConsole('👉🏻 Введен пароль: $password');
    await _addDelay(1000);
  }

  /// Клик по кнопке вход
  Future<void> tapLoginButton() async {
    final btnFinder = find.byKey(WarmingUpKeys.loginBtn);

    expect(btnFinder, findsOneWidget);
    await tester.tap(btnFinder);
    await tester.pumpAndSettle();
    tester.printToConsole('👉🏻 Тап по ${WarmingUpKeys.loginBtn}');
    await _addDelay(1000);
  }

  Future<void> _addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }
}
