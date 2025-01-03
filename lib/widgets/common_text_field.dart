import 'package:flutter/services.dart';
import 'package:aak_test/export.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final bool isEnabled;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.focusNode,
    this.hintText,
    this.obscureText = false,
    this.isEnabled = true,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Value Cannot be Empty!';
            }
            return null;
          },
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          enabled: isEnabled,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
