// lib/modal_util.dart
import 'package:flutter/material.dart';
import 'package:lotto/widgets/common/CustomAlert.dart';
import 'package:lotto/widgets/common/CustomModal.dart';

void showCustomAlert({
  required BuildContext context,
  required String title,
  required String content,
  required String buttonText,
  required VoidCallback onButtonPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlert(
        title: title,
        content: content,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed,
      );
    },
  );
}

void showCustomModal({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
}) {
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return CustomModal(
        child: child,
      );
    },
  );
}

