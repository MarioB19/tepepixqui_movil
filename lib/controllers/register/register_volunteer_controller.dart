import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tepepixqui_movil/models/volunteer_model.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';

class RegisterVolunteerController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  TextEditingController correo = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController numerotelefono = TextEditingController();
  TextEditingController fechaNacimiento = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final obscurePassword = true.obs;

  void updateFechaNacimiento(DateTime picked) {
    selectedDate.value = picked;
    fechaNacimiento.text = "${picked.day}/${picked.month}/${picked.year}";
  }

  List<String> dividirNombreYApellidos(String? displayName) {
    if (displayName == null || displayName.trim().isEmpty) {
      return ['', ''];
    }
    List<String> partesNombre = displayName.trim().split(RegExp(r'\s+'));

    String nombre = partesNombre.length > 1
        ? partesNombre.sublist(0, partesNombre.length - 1).join(' ')
        : partesNombre[0];

    String apellidos = partesNombre.length > 1 ? partesNombre.last : '';

    return [nombre, apellidos];
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    print('La visibilidad es ahora: ${obscurePassword.value}');
    update();
  }

  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) {
      return;
    }

    String nombreUsuario = username.text.trim();
    String correoElectronico = correo.text.trim();

    //TODO: Logica de username exists
    /*


    CollectionReference voluntarios =
        FirebaseFirestore.instance.collection('voluntarios');

    CollectionReference asociacion =
        FirebaseFirestore.instance.collection('asociacion');

    if (await UtilidadesLogin.existsUsername(
        voluntarios, asociacion, nombreUsuario)) {
      final dialogController = Get.put(DialogController());
      dialogController.showCustomDialog('El nombre de usuario ya esta en uso');

      return; 
    }

    if (await UtilidadesLogin.existsEmail(
        voluntarios, asociacion, correoElectronico)) {
      final dialogController = Get.put(DialogController());
      dialogController.showCustomDialog('El correo electrónico ya esta en uso');

      return; 
    }


  */

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: correo.text, password: password.text);

      User? user = userCredential.user;

      if (user != null) {
        final voluntario = VolunteerModel(
          fechaCreacion: Timestamp.now(),
          uidVoluntario: user.uid,
          provedor: "correo",
          nombre: nombre.text.trim(),
          apellidos: apellidos.text.trim(),
          correoElectronico: correo.text.trim().toLowerCase(),
          telefono: numerotelefono.text.trim().toLowerCase(),
          username: username.text.trim(),
          contrasena: password.text,
          fechaNacimiento: fechaNacimiento.text,
        );

        voluntario.toFirestore();

        await voluntario.save();
      } else {
        print('Error: No se pudo obtener la información del usuario');
      }
    } catch (error) {
      print('Error al agregar voluntario: $error');
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

/*
    final String googleEmail = googleSignInAccount.email;

    bool existe = await verificarDocumentoPorEmail(googleEmail); //TODO  


      if (!existe) {
              final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;





    
     //   Get.to(DatosFaltantesVoluntario(user: user, provedor: "google",));
      } else {

        await _auth.signOut();
        await GoogleSignIn().signOut();


        CustomDialogController.showCustomDialog('El correo electrónico ya esta en uso');
      }

      */
    } catch (error) {
      print('Error al autenticar con Google: $error');
    }
  }

  Future<void> guardarDatosFaltantes(User? user, String provider) async {
    if (!signupFormKey.currentState!.validate()) {
      return;
    }

    List<String> nombreYApellidos =
        dividirNombreYApellidos(user!.displayName ?? "");
    String nombre = nombreYApellidos.isNotEmpty ? nombreYApellidos[0] : '';
    String apellidos = nombreYApellidos.length > 1 ? nombreYApellidos[1] : '';

    String nombreUsuario = username.text.trim();

    //TODO: Logica nombre de usuario repetido
    /*
  CollectionReference voluntarios = FirebaseFirestore.instance.collection('voluntarios');
  CollectionReference asociacion = FirebaseFirestore.instance.collection('asociacion');


  if (await UtilidadesLogin.existsUsername(voluntarios, asociacion, nombreUsuario)) {
    final dialogController = Get.put(DialogController());
    dialogController.showCustomDialog('El nombre de usuario ya está en uso');
    return; 
    
  }

  */

    final voluntario = VolunteerModel(
      fechaCreacion: Timestamp.now(),
      uidVoluntario: user.uid,
      provedor: provider,
      nombre: nombre,
      apellidos: apellidos,
      correoElectronico: user.email?.trim().toLowerCase() ?? "",
      telefono: numerotelefono.text.trim(),
      username: nombreUsuario.trim(),
      contrasena: '',
      estado: "Aceptado",
      fechaNacimiento: fechaNacimiento.text,
    );

    voluntario.toFirestore();

    try {
    voluntario.save();
 
      Get.offAll(() => LoginPage());
    } catch (error) {
      //print('Error al agregar voluntario: $error');
    }
  }

  @override
  void onClose() {
    correo.clear();
    username.clear();
    nombre.clear();
    password.clear();
    apellidos.clear();
    numerotelefono.clear();
    fechaNacimiento.clear();

    super.onClose();
  }
}
