class ValidationsIncendio{
  static String? validarDuracion(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese un valor';
  }
  final n = num.tryParse(value);
  if (n == null) {
    return 'Por favor ingrese un número válido';
  }
  if (n is! int) {
    return 'Por favor ingrese un número entero';
  }
  return null;
}

}