import 'package:flutter/material.dart';

class Toast with ToastMixin {
  void show(
    BuildContext context, {
    required String text,
    required ToastStatus status,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          key: Key(text),
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: getBackgroundColorByStatus(status),
      ),
    );
  }
}

enum ToastStatus {
  success,
  error,
  warning,
}

mixin ToastMixin {
  Color getBackgroundColorByStatus(ToastStatus status) {
    switch (status) {
      case ToastStatus.success:
        return Colors.green.shade700;
      case ToastStatus.error:
        return Colors.red.shade700;
      case ToastStatus.warning:
        return Colors.yellow.shade700;
    }
  }
}
