import 'package:flutter_integration_test/utils/warming_up_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_integration_test/main.dart' as app;

import 'screens/alert_dialog_tester.dart';
import 'screens/login_tester.dart';
import 'screens/logout_tester.dart';

const _passwordCorrect = '123456';
const _passwordIncorrect = '000000';

// ignore: long-method
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  LoginTester loginTester;
  LogoutTester logoutTester;
  AlertDialogTester alertDialogTester;

  testWidgets(
    'Warming up end-to-end test',
    (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      loginTester = LoginTester(tester);
      logoutTester = LogoutTester(tester);
      alertDialogTester = AlertDialogTester(tester);

      await loginTester.checkScreenOpenedByKey(WarmingUpKeys.appBarTitleLoginKey);
      await loginTester.enterPassword(_passwordIncorrect);
      await loginTester.tapButton(WarmingUpKeys.loginBtn);
      await alertDialogTester.checkAlert();
      await alertDialogTester.tapToAlertButton(WarmingUpKeys.confirmAlert);
      await alertDialogTester.checkAlert(isOpened: false);
      await loginTester.checkScreenOpenedByKey(WarmingUpKeys.appBarTitleLoginKey);
      await loginTester.enterPassword(_passwordCorrect);
      await loginTester.tapButton(WarmingUpKeys.loginBtn);
      await logoutTester.checkScreenOpenedByKey(WarmingUpKeys.appBarTitleLogoutKey);
      await logoutTester.tapButton(WarmingUpKeys.logoutBtn);
      await alertDialogTester.checkAlert();
      await alertDialogTester.tapToAlertButton(WarmingUpKeys.cancelAlert);
      await alertDialogTester.checkAlert(isOpened: false);
      await logoutTester.tapButton(WarmingUpKeys.logoutBtn);
      await alertDialogTester.checkAlert();
      await alertDialogTester.tapToAlertButton(WarmingUpKeys.confirmAlert);
    },
  );
}
