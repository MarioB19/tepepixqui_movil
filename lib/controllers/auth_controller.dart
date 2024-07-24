import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tepepixqui_movil/pages/error_page.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/pages/ong/index_ong.dart';
import 'package:tepepixqui_movil/pages/volunteer/index_volunteer.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = Rxn<User>();
  var userType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.bindStream(_auth.authStateChanges());
  }

  Future<String> getUserType(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('ong').doc(uid).get();
      if (userDoc.exists) {
        userType.value = 'ong';
        return "ong";
      } else {
        userType.value = 'volunteer';
        return "volunteer";
      }
    } catch (e) {
      userType.value = '';
      return "";
    }
  }

  Future<void> login(String email, String password, String userTypeOut) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      currentUser.value = userCredential.user;
      userType.value = userTypeOut;
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

  String? getUid() {
    return currentUser.value?.uid;
  }
}
