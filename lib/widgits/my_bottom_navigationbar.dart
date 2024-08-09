import 'package:edumap/colors.dart';
import 'package:edumap/dictionary_screen.dart';
import 'package:edumap/home_screen.dart';
import 'package:edumap/number_fact_screen.dart';
import 'package:edumap/theme_provider.dart';
import 'package:edumap/university_screen.dart';
import 'package:flutter/material.dart';
import 'package:edumap/colors.dart';
import 'package:edumap/dictionary_screen.dart';
import 'package:edumap/home_screen.dart';
import 'package:edumap/number_fact_screen.dart';

import 'package:edumap/university_screen.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 2;
  static List<Widget> _widgetOptions = <Widget>[
    UniversityScreen(),
    DictionaryScreen(),
    HomeScreen(),
    NumberFactScreen(),
    Text('Profile Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
            isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
        unselectedItemColor:
            isDarkMode ? Colors.white60 : MyColor.secondaryColor,
        backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
            icon: Icon(Icons.school),
            label: 'University',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
            icon: Icon(Icons.book),
            label: 'Dictionary',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
            icon: Icon(Icons.category),
            label: 'NumberFact',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
