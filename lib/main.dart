import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dictionary_screen.dart';
import 'theme.dart';
import 'widgits/my_bottom_navigationbar.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      home: MyBottomNavigationBar(),
    );
  }
}
