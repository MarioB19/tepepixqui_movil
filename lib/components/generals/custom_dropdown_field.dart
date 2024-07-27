import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;
  final IconData? icon;

  const CustomDropdownField({
    super.key,
    required this.fieldName,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkMode ? Colors.white24 : Colors.grey.shade400,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black87 : Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        color: isDarkMode ? Colors.grey.shade800 : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldName,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  const SizedBox(width: 8.0),
                ],
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<T>(
                      isExpanded: true,
                      hint: Text(
                        hintText,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey,
                        ),
                      ),
                      value: value,
                      onChanged: onChanged,
                      items: items.map((item) {
                        return DropdownMenuItem<T>(
                          value: item,
                          child: Text(
                            item.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
