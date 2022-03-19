import 'package:flutter/material.dart';
import 'package:flutter_integration_test/utils/warming_up_keys.dart';

typedef BuildContextCallback = void Function(BuildContext context);

class AppAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final BuildContextCallback? onCancel;
  final String? cancelBtnText;
  final BuildContextCallback onConfirm;
  final String confirmBtnText;

  const AppAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    this.onCancel,
    this.cancelBtnText,
    required this.onConfirm,
    required this.confirmBtnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: WarmingUpKeys.alert,
      title: Text(title),
      content: Text(content),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      actions: [
        if (onCancel != null)
          TextButton(
            key: WarmingUpKeys.cancelAlert,
            child: Text(cancelBtnText!),
            onPressed: () => onCancel!(context),
          ),
        TextButton(
          key: WarmingUpKeys.confirmAlert,
          child: Text(confirmBtnText),
          onPressed: () => onConfirm(context),
        ),
      ],
    );
  }
}
