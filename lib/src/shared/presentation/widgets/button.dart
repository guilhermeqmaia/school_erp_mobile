import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget with ButtonMixin {
  final VoidCallback onPressed;
  final String text;
  final bool loading;
  final bool enabled;
  final ButtonType type;
  final double? height;
  final double? width;
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.loading = false,
    this.enabled = true,
    this.type = ButtonType.primary,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60,
      width: width ?? double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: getBackgroundColor(enabled, type),
          side: BorderSide(
            color: getBorderColor(enabled, type),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: loading || !enabled ? null : onPressed,
        child: loading
            ? const _LoadingIndicator()
            : Text(
                text,
                style: TextStyle(
                  color: getTextColor(enabled, type),
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}

enum ButtonType { primary, secondary }

mixin ButtonMixin {
  Color getBackgroundColor(bool enabled, ButtonType type) {
    if (!enabled) return Colors.grey.shade400;
    switch (type) {
      case ButtonType.primary:
        return Colors.orange.shade400;
      case ButtonType.secondary:
        return Colors.white;
    }
  }

  Color getBorderColor(bool enabled, ButtonType type) {
    if (!enabled) return Colors.grey.shade400;
    return Colors.orange.shade400;
  }

  Color getTextColor(bool enabled, ButtonType type) {
    if (!enabled) return Colors.white;
    switch (type) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return Colors.orange.shade400;
    }
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 10,
      child: Platform.isAndroid
          ? const CircularProgressIndicator(color: Colors.white)
          : const CupertinoActivityIndicator(color: Colors.white),
    );
  }
}
