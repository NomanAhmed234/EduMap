import 'package:edumap/colors.dart';
import 'package:edumap/theme_provider.dart';
import 'package:edumap/widgits/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class TranslatorWidget extends StatefulWidget {
  const TranslatorWidget({super.key});

  @override
  State<TranslatorWidget> createState() => _TranslatorWidgetState();
}

class _TranslatorWidgetState extends State<TranslatorWidget> {
  final TextEditingController _controller = TextEditingController();
  String translated = 'Translation';
  final GoogleTranslator _translator = GoogleTranslator();
  String selectedLanguage = 'ur'; // Default language is Punjabi
  final Map<String, String> languages = {
    'Punjabi': 'pa',
    'Hindi': 'hi',
    'Urdu': 'ur',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
  };

  @override
  void initState() {
    super.initState();
    _controller.addListener(_translateText);
  }

  void _translateText() async {
    final text = _controller.text;
    if (text.isNotEmpty) {
      final translation = await _translator.translate(
        text,
        from: 'en',
        to: selectedLanguage,
      );
      setState(() {
        translated = translation.text;
      });
    } else {
      setState(() {
        translated = 'Translation';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
      appBar: AppBar(
        foregroundColor:
            isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
        backgroundColor: isDarkMode ? MyColor.primaryColor : Colors.white,
        centerTitle: true,
        title: Text(
          'Translation',
          style: TextStyle(
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
              fontSize: 15),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor),
            onPressed: () {
              // Add your notification icon onPressed functionality here
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? MyColor.secondaryColor
                    : MyColor.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.translate,
                        color: isDarkMode ? Colors.white : Colors.white),
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: isDarkMode
                          ? MyColor.primaryColor
                          : MyColor.secondaryColor,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Text here...',
                        hintStyle: TextStyle(
                            color: isDarkMode ? Colors.white38 : Colors.white38,
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select language",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? MyColor.secondaryColor
                          : MyColor.secondaryColor),
                ),
                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(8),
                  style: TextStyle(
                      color: isDarkMode
                          ? MyColor.secondaryColor
                          : MyColor.secondaryColor),
                  iconEnabledColor: isDarkMode
                      ? MyColor.secondaryColor
                      : MyColor.secondaryColor,
                  dropdownColor:
                      isDarkMode ? MyColor.primaryColor : Colors.white,
                  iconSize: 24,
                  value: selectedLanguage,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                    _translateText();
                  },
                  items: languages.entries.map<DropdownMenuItem<String>>(
                    (entry) {
                      return DropdownMenuItem<String>(
                        value: entry.value,
                        child: Text(
                          entry.key,
                          style: TextStyle(color: MyColor.secondaryColor),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    isDarkMode ? MyColor.secondaryColor : MyColor.mediumColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      translated,
                      style: TextStyle(
                        fontSize: 30,
                        color: isDarkMode
                            ? MyColor.primaryColor
                            : MyColor.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
