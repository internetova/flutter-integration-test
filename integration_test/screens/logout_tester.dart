import 'package:flutter_integration_test/utils/warming_up_keys.dart';
import 'package:flutter_test/flutter_test.dart';

/// LogoutScreen
class LogoutTester {
  final WidgetTester tester;

  const LogoutTester(this.tester);

  Future<void> checkLogoutScreenOpened() async {
    final titleFinder = find.byKey(WarmingUpKeys.appBarTitleLogoutKey);

    expect(titleFinder, findsOneWidget);
    tester.printToConsole('👉🏻 LogoutScreen screen opens');
    await _addDelay(1000);
  }

  /// Клик по кнопке вход
  Future<void> tapLogoutButton() async {
    final btnFinder = find.byKey(WarmingUpKeys.logoutBtn);

    expect(btnFinder, findsOneWidget);
    await tester.tap(btnFinder);
    await tester.pumpAndSettle();
    tester.printToConsole('👉🏻 Тап по ${WarmingUpKeys.logoutBtn}');
    await _addDelay(1000);
  }

  Future<void> _addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }
}
