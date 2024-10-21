import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Finder Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Giphy Finder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ////////////////////////////////////////////////////////////////
  //VARIABLES
  ////////////////////////////////////////////////////////////////
  String searchedURL =
      "https://api.giphy.com/v1/gifs/trending?api_key=Q82iASwchXrmxgAv4ISLXApHrHUBnp3x&limit=10&offset=0&rating=g&bundle=messaging_non_clips";
  Color standardBlue = const Color(0xFF1e96f4);
  List<int> numList = <int>[
    10,
    20,
    30,
    40,
    50,
  ];
  int? _valueSelected = 10;
  String? searchedTerm;
  int? numResults = 10;
  int? numResultsShown = 10;
  List<String> listImgURL = [];
  List jsonData = [];
  List<TextButton> listImgWidget = [];
  TextEditingController searchTermController = TextEditingController();
  TextEditingController offsetTermController = TextEditingController();
  String validationText = "";
  int? offset = 0;

//////////////////////////////////////////////////////////////////
//METHODS
//////////////////////////////////////////////////////////////////
  ///Style Text
  Text myText(String textString, double fontsize_,
      [fontWeight_ = FontWeight.normal,
      fontColor_ = Colors.white,
      textHeight_ = 1.2]) {
    return Text(
      textString,
      style: TextStyle(
          fontSize: fontsize_,
          fontWeight: fontWeight_,
          color: fontColor_,
          height: textHeight_,
          fontFamily: 'VT323'),
    );
  }

  ///Get search query
  void searchQueryURL() {
    if (searchedTerm != null) {
      searchedURL =
          "https://api.giphy.com/v1/gifs/search?api_key=Q82iASwchXrmxgAv4ISLXApHrHUBnp3x&q=$searchedTerm&limit=$numResults&offset=$offset&rating=g&lang=en&bundle=messaging_non_clips";
      setState(() {
        validationText = "";
      });
    } else {
      setState(() {
        validationText = "Please enter a search term";
      });
    }
    doSearchTerm();
  }

  Future<void> doRefresh() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    print("Done Refreshing");
  }

  //utilize users search term
  Future doSearchTerm() async {
    var response = await http.get(Uri.parse(searchedURL));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      listImgURL.clear(); //clear list
      jsonData.clear();

      //get key "data" values of map[0]
      setState(() {
        jsonData = jsonResp["data"];
        displayNumberResults();
      });
      //for each, get the url key values and add to list

      for (int i = 0; i < jsonData.length; i++) {
        listImgURL.add(
            "https://media.giphy.com/media/${jsonData[i]["id"]}/giphy.${jsonData[i]["type"]}"); //convert to be usable by networkimage
        // print(jsonData[i]["id"]); //test
      }

      // print(jsonResp); //test
      // print("listOfImages Length = ${listImgURL.length}"); //test
      populateImageURL();
      // print(listImgWidget); //test
    } else {
      print("ERROR: $response.statusCode");
    }
  }

  displayNumberResults() {
    numResultsShown = jsonData.length;
  }

  _enlargeImage(int index, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    myText("${jsonData[index]["title"]}", 24, FontWeight.bold,
                        Colors.black),
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(url))),
                    ),
                    Text("URL: $url"),
                    Text("Rating: ${jsonData[index]["rating"]}"),
                    Text("Alternate Text:  ${jsonData[index]["alt_text"]}"),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(200, 205, 212, 208)),
                      ),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///Return trending gifs onload
  List<TextButton> showTrendingGifs() {
    searchedURL =
        "https://api.giphy.com/v1/gifs/trending?api_key=Q82iASwchXrmxgAv4ISLXApHrHUBnp3x&limit=10&offset=0&rating=g&bundle=messaging_non_clips";
    doSearchTerm();
    return listImgWidget;
  }

  void populateImageURL() {
    listImgWidget.clear(); //clear widget
    setState(() {
      listImgWidget = listImgURL.map<TextButton>((String value) {
        return TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(value),
              fit: BoxFit.cover,
            )),
          ),
          onPressed: () {
            _enlargeImage(listImgURL.indexOf(value), value);
            print("IsClicked");
          },
        );
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTrendingGifs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: standardBlue,
        title: Row(children: [
          //GIF ICON
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Center(
              child: myText(
                "GIF",
                16,
                FontWeight.w900,
                const Color(0xFF1e96f4),
              ),
            ),
          ),
          const SizedBox(width: 25),
          //TITLE TEXT
          myText(widget.title, 24, FontWeight.w600),
        ]),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('assets/images/background.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              //USER INPUT SELECTION
              //SEARCH TERMS
              TextField(
                keyboardType: TextInputType.name,
                controller: searchTermController,
                decoration: InputDecoration(
                  labelText: "Search Term",
                  hintText: "What do you want to find?",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchedTerm = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "$validationText",
                  style: TextStyle(color: Colors.red),
                ),
              ), //spacing
              //NUMBER OF RESULTS
              DropdownButtonFormField<int>(
                value: _valueSelected,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  label: Text("Number of Results",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 3.0), // Set the border color and thickness here
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 3.0), // Set the border color and thickness here
                  ),
                ),
                items: numList.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text("$value",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        )),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    numResults = value;
                    _valueSelected = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                controller: offsetTermController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: "Offset",
                  hintText: "Enter the starting point of the search",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    int? tempNum = int.tryParse(offsetTermController.text);
                    offset = tempNum;
                  });
                },
              ),

              //BUTTONS
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 87,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            searchedTerm = null;
                            numResults = 10;
                            _valueSelected = 10;
                            searchTermController.clear();
                            showTrendingGifs();

                            //doesnt reset offset because of choice
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: standardBlue),
                        child: myText("Reset", 15, FontWeight.w500)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 155,
                    child: ElevatedButton(
                        onPressed: () {
                          searchQueryURL();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: standardBlue),
                        child: myText("Find some Gifs!", 15, FontWeight.w500)),
                  )
                ],
              )),
              SizedBox(
                height: 15,
                child: myText("Number of Results: $numResultsShown", 12,
                    FontWeight.bold, Colors.black),
              ),

              ///GIF FOUND!
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(5),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: listImgWidget,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
