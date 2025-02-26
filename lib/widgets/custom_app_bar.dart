import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // For sharing functionality
import 'package:url_launcher/url_launcher.dart'; // For opening GitHub link

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Standard AppBar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple, // AppBar color
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Aptitude ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            TextSpan(
              text: 'Booster\n',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            TextSpan(
              text: 'By Adarsh Verma',
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      actions: [
        // GitHub Icon Button
        IconButton(
          icon: Icon(Icons.code, color: Colors.white), // GitHub-like icon
          onPressed: () async {
            const url = 'https://github.com/adarshverma7/Aptitude-Speed-Booster-Quiz-App'; // Your GitHub repo URL
            final Uri uri = Uri.parse(url); // Convert URL to Uri

            if (await canLaunchUrl(uri)) {
              await launchUrl(uri); // Open GitHub repo in browser
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Could not open GitHub repository.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        // Share Button
        IconButton(
          icon: Icon(Icons.share, color: Colors.white),
          onPressed: () async {
            const apkUrl = 'https://github.com/adarshverma7/Aptitude-Speed-Booster-Quiz-App/releases/latest/download/app-release.apk'; // APK download link

            await Share.share(
              'Download Aptitude Booster App 🚀: $apkUrl',
              subject: 'Aptitude Booster App',
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: Container(
          color: Colors.white,
          height: 2.0,
        ),
      ),
    );
  }
}
