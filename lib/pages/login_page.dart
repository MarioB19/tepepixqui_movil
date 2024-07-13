import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/custom_button.dart';
import 'package:tepepixqui_movil/components/custom_login_footer.dart';
import 'package:tepepixqui_movil/components/custom_text_field.dart';
import 'package:tepepixqui_movil/controllers/login_controller.dart';
import 'package:tepepixqui_movil/pages/forgot_password_page.dart';
import 'package:tepepixqui_movil/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.green.shade700)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green.shade700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Cambio aquí
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
                SizedBox(height: 30),
                Text(
                  'Please login to continue',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade700),
                ),
                SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Email',
                  controller: emailController,
                  onChanged: (value) => loginController.setEmail(value),
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Password',
                  controller: passwordController,
                  isPassword: true,
                  isPasswordVisible: isPasswordVisible,
                  onChanged: (value) => loginController.setPassword(value),
                  icon: Icons.lock,
                  onVisibilityToggle: togglePasswordVisibility,
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: 'Login',
                  onPressed: () => loginController.login(),
                  backgroundColor: Colors.green.shade700,
                  textColor: Colors.white,
                  borderRadius: 16.0,
                  icon: Icons.login,
                ),
              ],
            ),
            CustomLoginFooter(
              onForgotPasswordPressed: () {
                Get.to(ForgotPasswordPage());
              },
              onSignUpPressed: () {
                Get.to(RegisterPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
