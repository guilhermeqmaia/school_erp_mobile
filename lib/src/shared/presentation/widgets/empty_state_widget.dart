import 'package:flutter/material.dart';
import 'package:school_app/src/shared/presentation/assets/app_images.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? buttonOnTap;
  const EmptyStateWidget({
    Key? key,
    this.message = "Nenhum registro encontrado",
    this.buttonText,
    this.buttonOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.emptyState),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
            ),
            if (buttonText != null && buttonOnTap != null) ...[
              const SizedBox(height: 16),
              Button(
                onPressed: () => buttonOnTap?.call(),
                text: buttonText!,
                width: screenWidth * 0.5,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
