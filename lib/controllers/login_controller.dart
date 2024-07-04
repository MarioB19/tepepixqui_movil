import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  void login() {
    // Aquí puedes implementar la lógica de login
    if (email.value == "test@example.com" && password.value == "password") {
      Get.snackbar('Login Successful', 'Welcome!');
    } else {
      Get.snackbar('Login Failed', 'Invalid email or password');
    }
  }
}
