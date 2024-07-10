import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/custom_button.dart';
import 'package:tepepixqui_movil/components/custom_text_field.dart';
import 'package:tepepixqui_movil/controllers/login_controller.dart';

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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Please login to continue',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Email',
              controller: emailController,
              onChanged: (value) => loginController.setEmail(value),
              icon: Icons.email,
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
            SizedBox(height: 20),
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
      ),
    );
  }
}
