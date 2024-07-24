import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';

class ThemeSwitcher extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: themeController.toggleTheme,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            themeController.isDarkMode.value ? Icons.wb_sunny : Icons.nights_stay,
            key: ValueKey<bool>(themeController.isDarkMode.value),
            color: themeController.isDarkMode.value ? Colors.yellow : Colors.black,
            size: 30.0,
          ),
        ),
      );
    });
  }
}
