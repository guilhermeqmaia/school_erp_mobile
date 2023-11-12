import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter> inputFormatters;
  const Input({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters = const [],
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          autovalidateMode: widget.autovalidateMode,
          inputFormatters: widget.inputFormatters,
          cursorColor: Colors.orange.shade400,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.orange.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.orange.shade400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
