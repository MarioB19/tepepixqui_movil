import 'package:flutter/material.dart';
import 'package:tepepixqui_movil/components/generals/theme_switcher.dart';

import 'package:url_launcher/url_launcher.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final String redirectUrl;
  final VoidCallback onReportIconPressed;
  final VoidCallback onLogoutPressed;
  final double height;

  final double iconSize;

  const CustomHeader({
    super.key,
    required this.logoPath,
    required this.redirectUrl,
    required this.onReportIconPressed,
    required this.onLogoutPressed,
    this.height = kToolbarHeight,
    this.iconSize = 24.0,
  });

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(redirectUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $redirectUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.analytics, size: iconSize),
        onPressed: onReportIconPressed,
      ),
      title: InkWell(
        onTap: _launchURL,
        child: Image.asset(
          logoPath,
          height: 50,
        ),
      ),
      centerTitle: true,
      actions: [
        ThemeSwitcher(), 
        IconButton(
          icon: Icon(Icons.logout, size: iconSize),
          onPressed: onLogoutPressed,
        ),
        
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
