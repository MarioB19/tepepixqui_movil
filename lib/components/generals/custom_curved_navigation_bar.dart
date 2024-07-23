import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/navigation/navigation_controller.dart';

class CustomCurvedNavigationBar extends StatelessWidget {
  final List<Widget> pages;
  final List<IconData> icons;

  const CustomCurvedNavigationBar({super.key, required this.pages, required this.icons});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => pages[navigationController.currentIndex.value]),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: icons.map((icon) => Icon(icon, size: 30)).toList(),
        color: Colors.white,
        buttonBackgroundColor: const Color.fromARGB(255, 232, 220, 220),
        backgroundColor: Colors.green,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          navigationController.changePage(index);
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
