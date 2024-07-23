import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = Rxn<User>();
  var userType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.bindStream(_auth.authStateChanges());
  }

  Future<void> login(
      String email, String password, String userTypeComing) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      currentUser.value = userCredential.user;
      userType.value = userTypeComing;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Error desconocido";
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    currentUser.value = null;
    userType.value = '';
    Get.offAll(LoginPage());
  }

  String getUid() {
    return currentUser.value?.uid ?? '';
  }
}
