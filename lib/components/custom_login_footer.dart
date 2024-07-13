import 'package:flutter/material.dart';

class CustomLoginFooter extends StatelessWidget {
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignUpPressed;

  CustomLoginFooter({
    required this.onForgotPasswordPressed,
    required this.onSignUpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TextButton(
          onPressed: onForgotPasswordPressed,
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.green.shade700),
          ),
        ),
        SizedBox(height: 20), // Ajustamos el espaciado aquí
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? "),
            GestureDetector(
              onTap: onSignUpPressed,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
