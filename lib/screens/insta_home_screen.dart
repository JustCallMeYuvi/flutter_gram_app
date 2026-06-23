import 'package:flutter/material.dart';
import 'package:flutter_gram_app/screens/add_post_screen.dart';
import 'package:flutter_gram_app/home_page.dart';
import 'package:flutter_gram_app/screens/profile_screen.dart';
import 'package:flutter_gram_app/screens/reels_screen.dart';
import 'package:flutter_gram_app/screens/search_screen.dart';

class InstaHomeScreen extends StatefulWidget {
  const InstaHomeScreen({super.key});

  @override
  State<InstaHomeScreen> createState() => _InstaHomeScreenState();
}

class _InstaHomeScreenState extends State<InstaHomeScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),          
    const SearchScreen(),      
    const AddPostScreen(),     
    const ReelsScreen(),      
    const ProfileScreen(),     
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}


