import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/custom_button.dart';
import 'package:tepepixqui_movil/components/custom_login_footer.dart';
import 'package:tepepixqui_movil/controllers/signup_controller.dart';
import 'package:tepepixqui_movil/pages/forgot_password_page.dart';

class RegisterPage extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    SignupController controller = Get.put(SignupController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.green.shade700)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green.shade700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Register with Google',
              onPressed: controller.signUpWithGoogle ,
              backgroundColor: Colors.red.shade700,
              textColor: Colors.white,
              borderRadius: 16.0,
              icon: Icons.login,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Register with Form',
              onPressed: controller.signUpWithEmail,
              backgroundColor: Colors.green.shade700,
              textColor: Colors.white,
              borderRadius: 16.0,
              icon: Icons.app_registration,
            ),
            CustomLoginFooter(
              onForgotPasswordPressed: (){Get.to(ForgotPasswordPage());},
              onSignUpPressed: (){Get.to(RegisterPage());}
            ),
          ],
        ),
      ),
    );
  }
}
