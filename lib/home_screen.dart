import 'package:carousel_slider/carousel_slider.dart';
import 'package:edumap/colors.dart';
import 'package:edumap/dictionary_screen.dart';
import 'package:edumap/number_fact_screen.dart';
import 'package:edumap/theme_provider.dart';
import 'package:edumap/university_screen.dart';
import 'package:edumap/widgits/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> category = [
    "University",
    "Dictionary",
    "Trivia",
    "Math",
    "History",
    "Events",
  ];
  final Map<String, Widget Function(BuildContext)> categoryMap = {
    "University": (context) => UniversityScreen(),
    "Dictionary": (context) => DictionaryScreen(),
    "Trivia": (context) => NumberFactScreen(),
    "Math": (context) => NumberFactScreen(),
    "History": (context) => NumberFactScreen(),
    "Events": (context) => NumberFactScreen(),
  };

  final List<String> bannerImages = [
    'assets/university.png',
    'assets/dictionary.png',
    'assets/trivia.png',
    'assets/maths.png',
    'assets/history.png',
  ];

  final List<String> cardImages = [
    'assets/universitylogo.png',
    'assets/dictionarylogo.png',
    'assets/trivialogo.png',
    'assets/mathlogo.png',
    'assets/historylogo.png',
    'assets/eventslogo.png',
  ];
  void _search() {
    setState(() {
      if (category.contains(_controller)) {}
    });
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                        hintText: 'Search Category',
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
          ),

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
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color:
                              isDarkMode ? MyColor.primaryColor : Colors.white,
                          // margin: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        cardImages[index],
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            category[index],
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? MyColor.secondaryColor
                                                    : MyColor.secondaryColor),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 3),
                                            child: Text(
                                              "Click the button to start",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: isDarkMode
                                                      ? Colors.white38
                                                      : MyColor.secondaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Adjust the radius as needed
                                          ),
                                          foregroundColor: Colors.white,
                                          backgroundColor: isDarkMode
                                              ? MyColor.secondaryColor
                                              : MyColor.secondaryColor),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  categoryMap[category[index]]!(
                                                      context),
                                            ),
                                          );
                                        });
                                        // Button action
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                10), // Adjust padding as needed
                                        child: Text(
                                          'Get Start',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
