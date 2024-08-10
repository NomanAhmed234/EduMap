import 'dart:convert';

import 'package:edumap/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:edumap/colors.dart';
import 'package:edumap/maths_model.dart';
import 'package:http/http.dart' as http;
import 'package:edumap/widgits/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberFactScreen extends StatefulWidget {
  @override
  _NumberFactScreenState createState() => _NumberFactScreenState();
}

class _NumberFactScreenState extends State<NumberFactScreen> {
  List<String> recentSearches = [];
  Map<String, String> numberFactsData = {};
  NumberFact? _numberFact;
  bool _isLoading = false;
  String _selectedOption = 'trivia'; // Default option

  final List<String> _options = [
    'trivia',
    'year',
    'date',
    'math',
  ];
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    fetchNumberFact(4);
    loadRecentSearches();
  }

  Future<void> loadNumberFactsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      numberFactsData = Map<String, String>.from(
          prefs.getString('numberFacts') != null
              ? json.decode(prefs.getString('numberFacts')!)
              : {});
    });
  }

  Future<void> saveNumberFact(String number, String fact) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    numberFactsData[number] = fact;
    await prefs.setString('numberFacts', json.encode(numberFactsData));
    loadNumberFactsData();
  }

  Future<void> loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> saveSearch(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (recentSearches.contains(search)) {
      recentSearches.remove(search);
    }
    recentSearches.insert(0, search);
    if (recentSearches.length > 5) {
      recentSearches = recentSearches.sublist(0, 5);
    }
    await prefs.setStringList('recentSearches', recentSearches);
    loadRecentSearches();
  }

  Future<void> fetchNumberFact(int number) async {
    setState(() {
      _isLoading = true;
      saveSearch(number.toString());
    });

    final response = await http.get(Uri.parse(
        'http://numbersapi.com/$number/${_selectedOption.split('/').last}?json'));

    if (response.statusCode == 200) {
      setState(() {
        _numberFact = NumberFact.fromJson(response.body);
        saveNumberFact(number.toString(), _numberFact!.text);
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        hintText: 'Enter any Number',
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
                        fontWeight: FontWeight.bold,
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
              Center(
                child: Container(
                  width: double.maxFinite,
                  height: 200,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                        color: isDarkMode
                            ? MyColor.secondaryColor
                            : MyColor.secondaryColor,
                      ),
                    ),
                  ),
                ),
              )
            else if (_numberFact != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    child: Card(
                      color: isDarkMode
                          ? MyColor.secondaryColor
                          : MyColor.mediumColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Searched number: ${_numberFact!.number}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? MyColor.primaryColor
                                        : MyColor.secondaryColor,
                                  ),
                                ),
                                Text(
                                  'Category: ${_selectedOption}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? MyColor.primaryColor
                                        : MyColor.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _numberFact!.text,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isDarkMode
                                        ? Colors.white30
                                        : MyColor.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            else
              Text(
                'Enter a number to get a fact!',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : MyColor.primaryColor,
                ),
              ),
            Text(
              "Recent Search Number",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? MyColor.secondaryColor
                      : MyColor.secondaryColor),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     itemCount: recentSearches.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         margin: EdgeInsets.symmetric(vertical: 5),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //         ),
            //         child: ListTile(
            //           title: Text(recentSearches[index]),
            //           onTap: () {
            //             final number = int.tryParse(recentSearches[index]);
            //             if (number != null) {
            //               fetchNumberFact(number);
            //             }
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: numberFactsData.length,
                itemBuilder: (context, index) {
                  final number = numberFactsData.keys.elementAt(index);
                  final fact = numberFactsData[number]!;
                  return GestureDetector(
                    onTap: () {
                      fetchNumberFact(int.parse(number));
                    },
                    child: Card(
                        color: isDarkMode ? MyColor.primaryColor : Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Card(
                              color: isDarkMode
                                  ? MyColor.primaryColor
                                  : MyColor.secondaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$number',
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? MyColor.secondaryColor
                                          : Colors.white,
                                      fontSize: 30),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  fact,
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white38
                                          : MyColor.secondaryColor),
                                ),
                              ),
                            )
                          ],
                        )
                        //  ListTile(
                        //   title: Card(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Text(
                        //         '$number',
                        //         style: TextStyle(
                        //             color: MyColor.secondaryColor, fontSize: 30),
                        //       ),
                        //     ),
                        //   ),
                        //   subtitle: Text(fact),
                        //   onTap: () {
                        //     fetchNumberFact(int.parse(number));
                        //   },
                        // ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
