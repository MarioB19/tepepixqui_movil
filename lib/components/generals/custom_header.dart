import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final String redirectUrl;
  final VoidCallback onReportIconPressed;
  final VoidCallback onLogoutPressed;

  const CustomHeader({
    super.key,
    required this.logoPath,
    required this.redirectUrl,
    required this.onReportIconPressed,
    required this.onLogoutPressed,
  });

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(redirectUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $redirectUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.bar_chart_sharp, color: Colors.black, size: 32,),
        onPressed: onReportIconPressed,
      ),
      title: InkWell(
        onTap: _launchURL,
        child: Image.asset(
          logoPath,
          height: 60,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black, size: 32,),
          onPressed: onLogoutPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
