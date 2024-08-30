import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:holbegram/screens/Pages/feed.dart';
import 'package:holbegram/screens/Pages/search.dart';
import 'package:holbegram/screens/Pages/add_image.dart';
import 'package:holbegram/screens/Pages/favorite.dart';
import 'package:holbegram/screens/Pages/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          Feed(),
          Search(),
          AddImage(),
          Favorite(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (selectedIndex) => setState(() {
          _currentIndex = selectedIndex;
          pageController.jumpToPage(_currentIndex);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text(
              'Search',
              style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add),
            title: const Text(
              'Add image',
              style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite_outline),
            title: const Text(
              'Favorite',
              style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
        ],
      ), // ...
    );
  }
}
