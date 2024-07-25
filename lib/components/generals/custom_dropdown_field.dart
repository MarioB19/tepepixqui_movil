import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hintText;
  final T value;
  final List<T> items;
  final Function(T?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      value: items.contains(value) ? value : null,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
    );
  }
}
