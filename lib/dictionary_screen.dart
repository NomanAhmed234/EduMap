import 'dart:convert';
import 'package:edumap/colors.dart';
import 'package:edumap/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';
import 'theme_provider.dart';
import 'widgits/my_drawer.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<List<DictionaryModel>>? _futureDictionary;
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<List<DictionaryModel>> getPostApi(String word) async {
    var url =
        Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word");
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List responseBody = jsonDecode(response.body);
      return responseBody
          .map((json) => DictionaryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  void _search() {
    setState(() {
      _futureDictionary = getPostApi(_controller.text);
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _playAudio(String url) async {
    if (url.isNotEmpty) {
      await audioPlayer.play(UrlSource(url));
    } else {
      print('No audio URL available');
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
          'Use the Dictionary',
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
                    child: Icon(
                      Icons.search,
                      color: isDarkMode ? Colors.white : Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: isDarkMode
                          ? MyColor.primaryColor
                          : MyColor.secondaryColor,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter a word',
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
              child: _futureDictionary == null
                  ? Center(child: Text('Enter a word to search'))
                  : FutureBuilder<List<DictionaryModel>>(
                      future: _futureDictionary,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: isDarkMode
                                    ? MyColor.secondaryColor
                                    : MyColor.secondaryColor),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              'No data found',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var wordData = snapshot.data![index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    color: isDarkMode
                                        ? MyColor.primaryColor
                                        : Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        wordData.word ?? 'No word',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: isDarkMode
                                              ? MyColor.secondaryColor
                                              : MyColor.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            color: isDarkMode
                                                ? MyColor.secondaryColor
                                                : MyColor.secondaryColor,
                                            onPressed: () {
                                              if (wordData.phonetics != null &&
                                                  wordData
                                                      .phonetics!.isNotEmpty &&
                                                  wordData.phonetics![0]
                                                          .audio !=
                                                      null) {
                                                _playAudio(wordData
                                                    .phonetics![0].audio!);
                                              } else {
                                                print('No audio available');
                                              }
                                            },
                                            icon: Icon(
                                              Icons.speaker_rounded,
                                              color: isDarkMode
                                                  ? MyColor.secondaryColor
                                                  : MyColor.secondaryColor,
                                            ),
                                          ),
                                          Text(
                                            wordData.phonetic ?? 'No phonetic',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? MyColor.secondaryColor
                                                  : MyColor.secondaryColor,
                                            ),
                                          ),
                                          if (wordData.phonetics != null)
                                            for (var phonetic
                                                in wordData.phonetics!)
                                              GestureDetector(
                                                onTap: () {
                                                  if (phonetic.audio != null) {
                                                    _launchURL(phonetic.audio!);
                                                  }
                                                },
                                                child: Text(
                                                  phonetic.text ?? '',
                                                  style: TextStyle(
                                                    color: isDarkMode
                                                        ? MyColor.secondaryColor
                                                        : MyColor
                                                            .secondaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                          for (var meaning
                                              in wordData.meanings ?? [])
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  meaning.partOfSpeech ?? '',
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    color: isDarkMode
                                                        ? MyColor.secondaryColor
                                                        : MyColor
                                                            .secondaryColor,
                                                  ),
                                                ),
                                                for (var definition
                                                    in meaning.definitions ??
                                                        [])
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 4.0),
                                                    child: Text(
                                                      definition.definition ??
                                                          '',
                                                      style: TextStyle(
                                                        color: isDarkMode
                                                            ? Colors.white38
                                                            : MyColor
                                                                .primaryColor,
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
                              );
                            },
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
