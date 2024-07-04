import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

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
            TextField(
              onChanged: (value) => loginController.setEmail(value),
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => loginController.setPassword(value),
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => loginController.login(),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
