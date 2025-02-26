import 'package:flutter/material.dart';
import 'screens/home_page.dart'; // Import HomePage
import 'screens/revision_page.dart'; // Import RevisionPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aptitude Booster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(), // Use MainPage as the home screen
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(); // Controller for PageView
  int _currentIndex = 0; // Tracks the selected bottom navigation item

  // List of pages for PageView
  final List<Widget> _pages = [
    HomePage(), // Practice Page
    RevisionPage(), // Revision Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Update bottom navigation index when swiping
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Sync with PageView
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected index
            _pageController.jumpToPage(index); // Navigate to the corresponding page
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Revision',
          ),
        ],
      ),
    );
  }
}