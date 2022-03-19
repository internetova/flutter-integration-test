import 'package:flutter/material.dart';
import 'package:flutter_integration_test/ui/res/app_strings.dart';
import 'package:flutter_integration_test/ui/widgets/app_alert_dialog.dart';
import 'package:flutter_integration_test/utils/warming_up_keys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: AppStrings.titleAbbBarLogin),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<bool> isLoggedInState = ValueNotifier(false);
  GlobalKey<NavigatorState> navKey = GlobalKey();
  final String _password = '123456';
  late final TextEditingController _textEditingController;
  String? _enteredPassword;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
    _textEditingController.addListener(_passwordControllerListener);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_passwordControllerListener);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<bool>(
          valueListenable: isLoggedInState,
          builder: (_, isLoggedIn, __) => Text(
            isLoggedIn ? AppStrings.titleAbbBarLogout : widget.title,
            key:
                isLoggedIn ? WarmingUpKeys.appBarTitleLogoutKey : WarmingUpKeys.appBarTitleLoginKey,
          ),
        ),
      ),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoggedInState,
          builder: (_, isLoggedIn, __) {
            if (isLoggedIn == false) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(AppStrings.enterPassword),
                    const SizedBox(height: 60),
                    TextField(
                      controller: _textEditingController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 60),
                    MaterialButton(
                      key: WarmingUpKeys.loginBtn,
                      child: const Text(AppStrings.loginBtn),
                      onPressed: () => _checkPassword(_enteredPassword),
                      color: Colors.blueGrey.shade100,
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(AppStrings.userAccount),
                    const SizedBox(height: 60),
                    MaterialButton(
                      key: WarmingUpKeys.logoutBtn,
                      child: const Text(AppStrings.logoutBtn),
                      onPressed: _logout,
                      color: Colors.blueGrey.shade100,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _passwordControllerListener() {
    _enteredPassword = _textEditingController.text;
  }

  void _checkPassword(String? passw) {
    if (passw == null || passw.trim().isEmpty) return;

    final isUser = passw == _password;

    if (isUser) {
      isLoggedInState.value = true;
    } else {
      showDialog(
        context: context,
        builder: (context) => AppAlertDialog(
          title: 'Внимание!',
          content: 'Не верный пароль',
          onConfirm: (context) => Navigator.pop(context),
          confirmBtnText: 'Ок',
        ),
      );
    }

    _textEditingController.clear();
  }

  Future<void> _logout() async {
    final isLogout = await showDialog(
      context: context,
      builder: (context) => AppAlertDialog(
        title: 'Внимание!',
        content: 'Вы точно хотите выйти из кабинета?',
        onCancel: (context) => Navigator.pop(context, false),
        cancelBtnText: 'Остаться',
        onConfirm: (context) => Navigator.pop(context, true),
        confirmBtnText: 'Выйти',
      ),
    );

    if (isLogout) {
      isLoggedInState.value = false;
    }
  }
}
