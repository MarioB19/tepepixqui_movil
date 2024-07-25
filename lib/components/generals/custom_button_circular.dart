import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Object heroTag;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;

  const CircularButton({
    super.key,
    this.icon = Icons.add, // Valor predeterminado
    this.text = '', // Valor predeterminado
    required this.onPressed,
    this.heroTag = 'circular_button', // Valor predeterminado
    this.backgroundColor = const Color.fromARGB(255, 220, 220, 220), // Valor predeterminado
    this.foregroundColor = Colors.black, // Valor predeterminado
    this.size = 70.0, // Valor predeterminado
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          child: FloatingActionButton(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            heroTag: heroTag,
            onPressed: onPressed,
            child: Icon(icon, size: size / 2), // Ajustar el tamaño del icono
          ),
        ),
        if (text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
