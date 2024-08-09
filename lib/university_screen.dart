import 'dart:convert';
import 'package:edumap/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edumap/colors.dart';
import 'package:edumap/dictionary_screen.dart';
import 'package:edumap/model.dart';
import 'package:http/http.dart' as http;
import 'package:edumap/widgits/my_drawer.dart';
import 'package:edumap/widgits/search_data.dart';

import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({Key? key}) : super(key: key);

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  String n = "Pakistan";
  final TextEditingController _controller = TextEditingController();
  Future<List<UniversityModel>>? _futureUniversities;

  Future<List<UniversityModel>> getPostApi(String country) async {
    searchData.add(country);
    searchData.reversed;

    var url =
        Uri.parse("http://universities.hipolabs.com/search?country=$country");
    var response = await http.get(url);
    n = country;
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List responseBody = jsonDecode(response.body);
      return responseBody
          .map((json) => UniversityModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  void _search() {
    setState(() {
      _futureUniversities = getPostApi(_controller.text);
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
          'List of Universities',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter country name',
                        hintStyle: TextStyle(
                            color: isDarkMode ? Colors.white38 : Colors.white38,
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white),
                      onSubmitted: (value) => _search(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), // Adjust spacing as needed
            Expanded(
              child: _futureUniversities == null
                  ? Center(
                      child: Text('Enter a country to search',
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.white)))
                  : FutureBuilder<List<UniversityModel>>(
                      future: _futureUniversities,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: isDarkMode
                                ? MyColor.primaryColor
                                : MyColor.secondaryColor,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}',
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : MyColor.primaryColor)));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text(
                            'No data found',
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white
                                  : MyColor.secondaryColor,
                            ),
                          ));
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                child: Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: searchData.length,
                                    itemBuilder: (context, int index) {
                                      return Card(
                                        color: isDarkMode
                                            ? MyColor.primaryColor
                                            : Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(searchData[index],
                                              style: TextStyle(
                                                  color: isDarkMode
                                                      ? MyColor.secondaryColor
                                                      : MyColor
                                                          .secondaryColor)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, int index) {
                                    var university = snapshot.data![index];
                                    return Card(
                                      color: isDarkMode
                                          ? MyColor.primaryColor
                                          : Colors.white,
                                      child: ListTile(
                                        title: Text(
                                          university.name ?? 'No name',
                                          style: TextStyle(
                                              color: isDarkMode
                                                  ? MyColor.secondaryColor
                                                  : MyColor.secondaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              university.country ??
                                                  'No country',
                                              style: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.white38
                                                      : MyColor.primaryColor),
                                            ),
                                            for (var webPage
                                                in university.webPages ?? [])
                                              GestureDetector(
                                                onTap: () {
                                                  try {
                                                    _launchURL(webPage);
                                                  } catch (e) {
                                                    print(
                                                        'Error launching URL: $e');
                                                  }
                                                },
                                                child: Text(
                                                  webPage,
                                                  style: TextStyle(
                                                    color: isDarkMode
                                                        ? MyColor.secondaryColor
                                                        : MyColor
                                                            .secondaryColor,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
