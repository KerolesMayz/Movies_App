import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors_manager/colors_Manager.dart';

class DialogUtils {
  static void showLoadingDialog(
    BuildContext context, {
    String? message,
    bool? dismissible,
  }) {
    showCupertinoDialog(
      barrierDismissible: dismissible ?? true,
      context: context,
      builder: (context) => AlertDialog(
        content: message == null
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: ColorsManager.yellow),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircularProgressIndicator(
                        color: ColorsManager.yellow,
                      ),
                      Text(message),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  static void showMessageDialog(
    BuildContext context,
    String content, {
    String? positiveTitle,
    String? negativeTitle,
    VoidCallback? positiveAction,
    VoidCallback? negativeAction,
  }) {
    List<Widget> actions = [];
    if (positiveTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            positiveAction?.call();
          },
          child: Text(positiveTitle),
        ),
      );
    }
    if (negativeTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negativeAction?.call();
          },
          child: Text(negativeTitle),
        ),
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (context) =>
          AlertDialog(content: Text(content), actions: actions),
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
