import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String labelText;
  final String? Function(T?)? validator;
  final String hintText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final Color dropdownColor;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.labelText,
    this.validator,
    this.hintText = '',
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.fillColor = Colors.white,
    this.dropdownColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
        // labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0), // Adjust horizontal padding
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: focusedBorderColor,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor: fillColor,

        hintText: hintText,
      ),
      validator: validator,
      style: const TextStyle(color: Colors.black),
      dropdownColor: dropdownColor,
    );
  }
}
