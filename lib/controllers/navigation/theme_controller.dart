import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  Color appBarLogin() {
    return !isDarkMode.value ? const Color.fromARGB(255, 255, 255, 255) : Colors.grey.shade900;

  }
   Color navigationBar() {
    return !isDarkMode.value ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0);

  }

     Color logosNavigationBar() {
    return isDarkMode.value ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0);
  }






 
}
