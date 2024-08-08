import 'package:edumap/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:edumap/colors.dart';
import 'package:edumap/maths_model.dart';
import 'package:http/http.dart' as http;
import 'package:edumap/widgits/my_drawer.dart';
import 'package:provider/provider.dart';

class NumberFactScreen extends StatefulWidget {
  @override
  _NumberFactScreenState createState() => _NumberFactScreenState();
}

class _NumberFactScreenState extends State<NumberFactScreen> {
  NumberFact? _numberFact;
  bool _isLoading = false;
  String _selectedOption = 'trivia'; // Default option

  final List<String> _options = [
    'trivia',
    'year',
    'date',
    'math',
  ];

  Future<void> fetchNumberFact(int number) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'http://numbersapi.com/$number/${_selectedOption.split('/').last}?json'));

    if (response.statusCode == 200) {
      setState(() {
        _numberFact = NumberFact.fromJson(response.body);
        _isLoading = false;
      });
    } else {
      // Handle the error
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load number fact');
    }
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
          'Number Fact',
          style: TextStyle(
            color: isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            fontSize: 15,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color:
                  isDarkMode ? MyColor.secondaryColor : MyColor.secondaryColor,
            ),
            onPressed: () {
              // Add your notification icon onPressed functionality here
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                    child: Icon(Icons.search,
                        color: isDarkMode ? Colors.white : Colors.white),
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: isDarkMode
                          ? MyColor.primaryColor
                          : MyColor.secondaryColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter country name',
                        hintStyle: TextStyle(
                            color: isDarkMode ? Colors.white38 : Colors.white38,
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white),
                      onSubmitted: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          fetchNumberFact(number);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Select Category",
                    style: TextStyle(
                        color: isDarkMode
                            ? MyColor.secondaryColor
                            : MyColor.secondaryColor),
                  ),
                ),
                SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
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
                    value: _selectedOption,
                    items: _options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(child: Text(option)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_isLoading)
              CircularProgressIndicator(
                color:
                    isDarkMode ? MyColor.primaryColor : MyColor.secondaryColor,
              )
            else if (_numberFact != null)
              Card(
                color: isDarkMode ? MyColor.secondaryColor : Colors.white,
                child: Column(
                  children: [
                    Text(
                      'Number: ${_numberFact!.number}',
                      style: TextStyle(
                        fontSize: 24,
                        color: isDarkMode ? Colors.white : MyColor.primaryColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _numberFact!.text,
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode
                              ? Colors.white30
                              : MyColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Text(
                'Enter a number to get a fact!',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : MyColor.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
