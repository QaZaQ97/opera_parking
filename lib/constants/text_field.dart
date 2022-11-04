import 'package:flutter/material.dart';

Widget defTextField(TextEditingController controller, String labelText, bool isCarNumber) {
  return TextField(
    controller: controller,
    keyboardType: isCarNumber ? TextInputType.number : null,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    ),
  );
}
