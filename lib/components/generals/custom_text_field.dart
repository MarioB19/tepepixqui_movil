import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? labelText; // Nuevo parámetro para el texto del decorador
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
  final int maxLines; // Nuevo parámetro para el máximo de líneas
  final int minLines; // Nuevo parámetro para el mínimo de líneas

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText, // Asignar el parámetro opcional
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
    this.maxLines = 5, // Valor por defecto para el máximo de líneas
    this.minLines = 1, // Valor por defecto para el mínimo de líneas
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      readOnly: readOnly, // Aplicar el parámetro readOnly
      maxLines: isPassword ? 1 : maxLines, // Limitar maxLines si es una contraseña
      minLines: minLines, // Establecer el mínimo de líneas
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText, // Utilizar el nuevo parámetro para el texto del decorador
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon ?? (isPassword // Aplicar ícono de sufijo o visibilidad de contraseña
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onVisibilityToggle,
              )
            : null),
        errorMaxLines: 3,
      ),
    );
  }
}
