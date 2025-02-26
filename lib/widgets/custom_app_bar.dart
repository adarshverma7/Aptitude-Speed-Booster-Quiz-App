import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening GitHub link

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Keep the same height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple, // Keep the same color
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Aptitude ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25, // Keep the same font size
              ),
            ),
            TextSpan(
              text: 'Booster\n',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 25, // Keep the same font size
              ),
            ),
            TextSpan(
              text: 'By Adarsh Verma',
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 14, // Keep the same font size
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
            const url = 'https://github.com/your-username/your-repo'; // Replace with your GitHub repo URL
            if (await canLaunch(url)) {
              await launch(url); // Open GitHub repo in browser
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Could not launch GitHub repository.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        // Share Button
        IconButton(
          icon: Icon(Icons.share, color: Colors.white),
          onPressed: () {
            Share.share(
              'Check out this amazing app: Aptitude Booster! 🚀\nGitHub Repository: https://github.com/your-username/your-repo', // Replace with your GitHub repo URL
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