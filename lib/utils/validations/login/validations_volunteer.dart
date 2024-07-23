import 'package:tepepixqui_movil/utils/time.dart';

class ValidationsVolunteer {
  
  
  static String? validarContrasena(String? contrasena) {
    if (contrasena == null ||
        contrasena.length < 8 ||
        contrasena.length > 50 ||
        !contrasena.contains(RegExp(r'[0-9]')) ||
        !contrasena.contains(RegExp(r'[A-Z]')) ||
        !contrasena.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "La contraseña debe tener minimo 8 caracteres, máximo 50,un carácter númerico y una letra mayúscula";
    }
    return null;
  }

  
  static String? validarCorreoElectronico(String? correo) {
    if (correo == null ||
        !RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(correo)) {
      return "El correo electrónico no es válido";
    }
    return null;
  }


  static String? validarNombre(String? nombre) {
    if (nombre == null || nombre.length < 2 || nombre.length > 70) {
      return "El nombre debe tener entre 2 y 70 caracteres";
    }
    return null;
  }


  static String? validarApellidos(String? apellidos) {
    if (apellidos == null || apellidos.length < 2 || apellidos.length > 70) {
      return "Los apellidos deben tener entre 2 y 70 caracteres";
    }
    return null;
  }

  static String? validarNombreUsuario(String? nombreUsuario) {
    if (nombreUsuario == null ||
        nombreUsuario.length < 4 ||
        nombreUsuario.length > 20) {
      return "El nombre de usuario debe tener entre 4 y 20 caracteres";
    }
    return null;
  }

  static String? validarEdad(String fechaNacimientoStr) {
    
    List<String> partes = fechaNacimientoStr.split('/') ;
    if (partes.length != 3) {
      return "El formato de la fecha de nacimiento es incorrecto";
    }
    String fechaFormatoISO =
        '${partes[2]}-${partes[1].padLeft(2, '0')}-${partes[0].padLeft(2, '0')}';

    DateTime? fechaNacimiento = DateTime.tryParse(fechaFormatoISO);

    
    if (fechaNacimiento == null) {
      return "Selecciona una fecha de nacimiento válida";
    }

       
    DateTime hoy = Time.getNowInMexicoCity();
    int edad = hoy.year - fechaNacimiento.year;
    if (fechaNacimiento.month > hoy.month ||
        (fechaNacimiento.month == hoy.month && fechaNacimiento.day > hoy.day)) {
      edad--; 
    }

    if (edad < 18) {
      return "Debes ser mayor de 18 años para registrarte";
    }

    return null;
  }

  static String? validarCelular(String? celular) {
    if (celular == null ||
        !RegExp(r'^\d+$').hasMatch(celular) ||
        celular.length != 10) {
      return "Número no valido";
    }
    return null;
  }
}
