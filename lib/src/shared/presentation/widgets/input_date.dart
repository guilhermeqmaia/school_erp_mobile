import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:school_app/src/shared/presentation/widgets/input.dart';

class InputDate extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter> inputFormatters;

  const InputDate({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: controller,
      label: label,
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '##/##/####',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.eager,
          initialText: "__/__/____",
        )
      ],
      validator: validator,
      autovalidateMode: autovalidateMode,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      hint: hint,
    );
  }
}
