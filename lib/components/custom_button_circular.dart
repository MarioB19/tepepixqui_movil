import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Object heroTag;

  const CircularButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 220, 220, 220),
              foregroundColor: Colors.black,
              heroTag: heroTag,
              onPressed: onPressed,
              child: Icon(icon),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
