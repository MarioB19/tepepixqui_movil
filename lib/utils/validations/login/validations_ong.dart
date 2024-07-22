

class ValidationsOng {
  static String? validarDescripcionActividades(String? descripcion) {
    if (descripcion == null ||
        descripcion.length < 100 ||
        descripcion.length > 10000) {
      return "La descripción de actividades debe tener entre 100 y 10,000 caracteres";
    }
    return null;
  }

  static String? validarCorreoElectronicoOrganizacion(String? correo) {
    if (correo == null ||
        !RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
            .hasMatch(correo)) {
      return "El correo electrónico no es válido";
    }
    return null;
  }

  static String? validarContrasenaOrganizacion(String? contrasena) {
    if (contrasena == null ||
        contrasena.length < 8 ||
        contrasena.length > 50 ||
        !contrasena.contains(RegExp(r'[0-9]')) ||
        !contrasena.contains(RegExp(r'[A-Z]')) ||
        !contrasena.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "La contraseña debe tener minimo 8 caracteres, máximo 50, un carácter numérico y una letra mayúscula";
    }
    return null;
  }

  static String? validarNombreOrganizacion(String? nombre) {
    if (nombre == null || nombre.length < 3 || nombre.length > 100) {
      return "El nombre de la organización debe tener entre 3 y 100 caracteres";
    }
    return null;
  }

  static String? validarNumeroTelefonicoOrganizacion(String? celular) {
        if (celular == null ||
        !RegExp(r'^\d+$').hasMatch(celular) ||
        celular.length != 10) {
      return "Número no valido";
    }
    return null;
  }

  

  static String? validarNombreRepresentante(String? nombreRepresentante) {
    if (nombreRepresentante == null ||
        nombreRepresentante.length < 10 ||
        nombreRepresentante.length > 100) {
      return "El nombre del representante debe tener entre 10 y 100 caracteres";
    }
    return null;
  }

  static String? validarFormatoPDF(String? nombreArchivo) {
    if (nombreArchivo == null || !nombreArchivo.toLowerCase().endsWith(".pdf")) {
      return "El archivo debe estar en formato PDF";
    }
    return null;
  }
  
  
  
}
