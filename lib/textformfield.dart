import 'package:flutter/material.dart';

class TextFormFieldWrapper extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? prefixIconData; // New property to hold the icon data

  const TextFormFieldWrapper({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.prefixIconData, // Update constructor to accept icon data
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIconData != null
              ? Icon(prefixIconData) // Use prefixIcon to display the icon
              : null, // If no icon data provided, don't display any icon
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.amber,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
