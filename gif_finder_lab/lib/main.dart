import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

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
  String searchedURL =
      "https://api.giphy.com/v1/gifs/search?api_key=Q82iASwchXrmxgAv4ISLXApHrHUBnp3x&q=cats&limit=10&offset=0&rating=g&lang=en&bundle=messaging_non_clips";
  Color standardBlue = Color(0xFF1e96f4);
  List<int> numList = <int>[
    10,
    20,
    30,
    40,
    50,
  ];
  String? searchedTerm;
  int? numResults = 10;

  ///TextStyle
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
          height: textHeight_),
    );
  }

  void searchQueryURL() {
    if (searchedTerm != null) {
      searchedURL =
          "https://api.giphy.com/v1/gifs/search?api_key=Q82iASwchXrmxgAv4ISLXApHrHUBnp3x&q=$searchedTerm&limit=$numResults&offset=0&rating=g&lang=en&bundle=messaging_non_clips";
    } else {
      searchedURL =
          "https://api.giphy.com/v1/gifs/search?api_key=Q82iASwchXrmxgAv4ISLXApHrHUBnp3x&q=cats&limit=10&offset=0&rating=g&lang=en&bundle=messaging_non_clips";
    }
  }

  Future<void> doRefresh() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    print("Done Refreshing");
  }

  Future doRandom() async {
    var response = await http.get(Uri.parse(searchedURL));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      //get map
      //get map[0]
      //get key "data" values
      //for each, get the url key values and add to list

      // print(jsonResp);
    } else {
      print("ERROR: $response.statusCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1e96f4),
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
                  searchedTerm = value;
                },
              ),
              const SizedBox(height: 10), //spacing
              //NUMBER OF RESULTS
              DropdownButtonFormField<int>(
                value: numList[0],
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
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
                  numResults = value;
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
                        onPressed: () {},
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
                          doRandom();
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

              ///GIF FOUND!
              Expanded(
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(5),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                      child: const Text("He'd have you all unravel at the"),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[200],
                      child: const Text('Heed not the rabble'),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[300],
                      child: const Text('Sound of screams but the'),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[400],
                      child: const Text('Who scream'),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[500],
                      child: const Text('Revolution is coming...'),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[600],
                      child: const Text('Revolution, they...'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
