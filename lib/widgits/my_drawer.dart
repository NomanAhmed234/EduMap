import 'package:edumap/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart'; // Import the theme provider

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Drawer(
      surfaceTintColor:
          isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
      backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        isDarkMode ? MyColor.primaryColor : Colors.white,
                    radius: 35,
                  ),
                  Text(
                    "Noman Ahmed",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode ? MyColor.primaryColor : Colors.white),
                  ),
                  Text(
                    "@nomanahmed",
                    style: TextStyle(
                        color:
                            isDarkMode ? MyColor.primaryColor : Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor,
              ),
            ),
            onTap: () {
              // Add your drawer item onPressed functionality here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            title: Text(
              'Setting',
              style: TextStyle(
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor,
              ),
            ),
            onTap: () {
              // Add your drawer item onPressed functionality here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            title: Text(
              'Upgrade to Premium',
              style: TextStyle(
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor,
              ),
            ),
            onTap: () {
              // Add your drawer item onPressed functionality here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            title: Text(
              'FAQs',
              style: TextStyle(
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor,
              ),
            ),
            onTap: () {
              // Add your drawer item onPressed functionality here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            title: Text(
              'Share the app',
              style: TextStyle(
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor,
              ),
            ),
            onTap: () {
              // Add your drawer item onPressed functionality here
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor,
              ),
            ),
            onTap: () {
              // Add your drawer item onPressed functionality here
            },
          ),
          Divider(
            color: isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
          ), // Adds a divider before the theme toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: isDarkMode
                        ? MyColor.secondaryColor
                        : MyColor.secondaryColor,
                  ),
                ),
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                  activeColor:
                      isDarkMode ? MyColor.secondaryColor : Colors.white,
                  inactiveTrackColor:
                      isDarkMode ? MyColor.primaryColor : Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
