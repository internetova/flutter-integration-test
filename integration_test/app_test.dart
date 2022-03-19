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

      await loginTester.checkLoginScreenOpened();
      await loginTester.enterPassword(_passwordIncorrect);
      await loginTester.tapLoginButton();
      await alertDialogTester.checkAlertOpened();
      await alertDialogTester.tapToAlertButton(WarmingUpKeys.confirmAlert);
      await alertDialogTester.checkAlertClosed();
      await loginTester.checkLoginScreenOpened();
      await loginTester.enterPassword(_passwordCorrect);
      await loginTester.tapLoginButton();
      await logoutTester.checkLogoutScreenOpened();
      await logoutTester.tapLogoutButton();
      await alertDialogTester.checkAlertOpened();
      await alertDialogTester.tapToAlertButton(WarmingUpKeys.cancelAlert);
      await alertDialogTester.checkAlertClosed();
      await logoutTester.tapLogoutButton();
      await alertDialogTester.checkAlertOpened();
      await alertDialogTester.tapToAlertButton(WarmingUpKeys.confirmAlert);
    },
  );
}
