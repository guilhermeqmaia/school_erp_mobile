import 'package:flutter/material.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';

/// [DeleteItemDialog] is used to confirm actions that will delete an item.
/// The value will be returned as a boolean
/// It will use navigation return by Modular.to.pop([value])
/// The return also can be null if the user dismiss the dialog
class DeleteItemDialog extends StatelessWidget {
  final String message;
  const DeleteItemDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Button(
                    key: const Key("deny_button"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    text: "Não",
                    type: ButtonType.secondary,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Button(
                    key: const Key("confirm_button"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    text: "Sim",
                    height: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
