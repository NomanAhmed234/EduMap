import 'package:carousel_slider/carousel_slider.dart';
import 'package:edumap/colors.dart';
import 'package:edumap/theme_provider.dart';
import 'package:edumap/widgits/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> bannerImages = [
    'assets/university.png',
    'assets/dictionary.png',
    'assets/trivia.png',
    'assets/maths.png',
    'assets/history.png',
  ];

  final List<String> cardImages = [
    'assets/university.png',
    'assets/dictionary.png',
    'assets/trivia.png',
    'assets/maths.png',
    'assets/history.png',
  ];

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
          'Hello, Noman Ahmed!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Auto-sliding banner
          CarouselSlider(
            options: CarouselOptions(
              height: 150.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            items: bannerImages.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          imagePath,
                          height: 150.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as needed
                              ),
                              backgroundColor: MyColor.secondaryColor,
                              foregroundColor: Colors.white),
                          onPressed: () {
                            // Button action
                          },
                          child: Text(
                            'UpComing',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Populars",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? MyColor.secondaryColor
                            : MyColor.secondaryColor),
                  ),
                  // Scrollable cards
                  Expanded(
                    child: ListView.builder(
                      itemCount: cardImages.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // margin: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  cardImages[index],
                                  height: 150.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the radius as needed
                                    ),
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                  ),
                                  onPressed: () {
                                    // Button action
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            10), // Adjust padding as needed
                                    child: Text(
                                      'UpComing',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
