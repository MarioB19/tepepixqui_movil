import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isPasswordVisible;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final IconData? icon;
  final VoidCallback? onVisibilityToggle;
  final String? Function(String?)? validator;
  final bool readOnly; // Nuevo parámetro para solo lectura
  final Widget? suffixIcon; // Nuevo parámetro para el ícono de sufijo

  CustomTextField({
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.icon,
    this.onVisibilityToggle,
    this.validator,
    this.readOnly = false, // Valor por defecto es falso
    this.suffixIcon, // Valor por defecto es nulo
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      onChanged: onChanged,
      cursorColor: Colors.green.shade700,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      readOnly: readOnly, // Aplicar el parámetro readOnly
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.green.shade700),
        ),
        prefixIcon: icon != null ? Icon(icon, color: Colors.green.shade700) : null,
        suffixIcon: suffixIcon ?? (isPassword // Aplicar ícono de sufijo o visibilidad de contraseña
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.green.shade700,
                ),
                onPressed: onVisibilityToggle,
              )
            : null),
      ),
      style: TextStyle(color: Colors.green.shade900),
    );
  }
}
