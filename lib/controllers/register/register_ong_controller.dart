import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tepepixqui_movil/components/generals/custom_dialog.dart';
import 'package:tepepixqui_movil/models/ong_model.dart';

import 'package:tepepixqui_movil/pages/register/register_ong_form2.dart';
import 'package:tepepixqui_movil/pages/register/register_verify_email.dart';
import 'package:tepepixqui_movil/utils/database/login_querys.dart';
import 'package:tepepixqui_movil/utils/time.dart';

class RegisterOngController extends GetxController {
  Rxn<String> pdfFileUrl = Rxn<String>();

  final nombreONGController = TextEditingController();
  final passwordController = TextEditingController();
  final nombreRepresentanteController = TextEditingController();
  final correoController = TextEditingController();
  final numTelefonoController = TextEditingController();

  RxList<String> selectedOptions = <String>[].obs;
  var actividadesController = TextEditingController();
  var pdfFileName = Rxn<String>();

  var nivelOperativo = 'Estatal'.obs;

  var cantidadPersonas = '1-25 personas'.obs;

  var tiempoFuncionamiento = '0 años'.obs;

  Rxn<File> selectedPdfFile = Rxn<File>();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey2 = GlobalKey<FormState>();

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      pdfFileName.value = result.files.single.name;

      selectedPdfFile.value = File(result.files.single.path!);
    } else {
      pdfFileName.value = null;
      selectedPdfFile.value = null;
      Get.snackbar('Error', 'No se seleccionó un archivo');
    }
  }

  Future<void> uploadPdfFile() async {
    if (selectedPdfFile.value != null) {
      try {
        String fileName = selectedPdfFile.value!.path.split('/').last;
        var storageRef = FirebaseStorage.instance.ref().child('pdfs/$fileName');
        var uploadTask = await storageRef.putFile(selectedPdfFile.value!);
        var downloadUrl = await uploadTask.ref.getDownloadURL();

        pdfFileUrl.value = downloadUrl;
      } catch (e) {
        print("Error al subir archivo: $e");
        Get.snackbar('Error', 'No se pudo subir el archivo: $e');
      }
    } else {
      Get.snackbar('Error', 'No se seleccionó un archivo PDF');
    }
  }

  void setTiempoFuncionamiento(String? newValue) {
    if (newValue != null) {
      tiempoFuncionamiento.value = newValue;
    }
  }

  void setCantidadPersonas(String? newValue) {
    if (newValue != null) {
      cantidadPersonas.value = newValue;
    }
  }

  void setNivelOperativo(String? newValue) {
    if (newValue != null) {
      nivelOperativo.value = newValue;
    }
  }

  var selectedDate = DateTime.now().obs;
  var obscurePassword = true.obs;

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> signupPart1() async {
    if (!signupFormKey2.currentState!.validate()) {
      return;
    }

    if (await LoginQuerys.checkIfFieldExists(
        "username", nombreONGController.text.trim())) {
      CustomDialogController.showCustomDialog(
          'El nombre de usuario ya está en uso');
      return;
    }

    if (await LoginQuerys.checkIfFieldExists(
        "correoElectronico", correoController.text.trim().toLowerCase())) {
      CustomDialogController.showCustomDialog(
          'El correo electronico ya está en uso');
      return;
    }

    Get.to(RegisterOngForm2());
  }

  Future<void> signupPart2() async {
    if (!signupFormKey.currentState!.validate()) {
      return;
    }

    if (pdfFileName.value == null) {
      CustomDialogController.showCustomDialog('Agregue un archivo PDF');
      return;
    }

    if (!pdfFileName.value!.endsWith(".pdf")) {
      CustomDialogController.showCustomDialog(
          'Debe seleccionar un archivo PDF');
      return;
    }

    await uploadPdfFile();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correoController.text.trim().toLowerCase(),
        password: passwordController.text,
      );

      final uid = userCredential.user?.uid;
      final asociacion = OngModel(
          fechaSolicitud: Timestamp.fromDate(Time.getNowInMexicoCity()),
          uid: uid!,
          username: nombreONGController.text.trim().toLowerCase(),
          tiempoFuncionamiento: tiempoFuncionamiento.value.toString(),
          correoElectronico: correoController.text.trim().toLowerCase(),
          telefono: numTelefonoController.text.trim(),
          nombreRepresentante: nombreRepresentanteController.text,
          cantidadPersonas: cantidadPersonas.value.toString(),
          nivelOperativo: nivelOperativo.value.toString(),
          descripcionActividades: actividadesController.text,
          cartaNotariadaPDF: pdfFileUrl.value.toString());

      asociacion.save();

      await userCredential.user?.sendEmailVerification();
      Get.offAll(RegisterVerifyEmail(correoElectronico: correoController.text.trim().toLowerCase(),));
    } on FirebaseAuthException catch (authError) {
      print('Error al crear usuario: ${authError.message}');
    } catch (error) {
      print('Error al agregar asociación: $error');
      Get.snackbar('Error', 'Error al agregar asociación: $error');
    }
  }
}
