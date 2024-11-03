import 'dart:convert';

import 'package:flutter/material.dart';
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
      title: 'DOG CEO API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PAUSE FOR PAWS'),
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
// #region VARIABLES
  //Color Palette for this API
  Color lightBrown = const Color(0xffe5b17f);
  Color mediumBrown = const Color(0xffc99160);
  static const Color darkBrown = Color(0xff5e3924);

  //USERINPUT
  String breedName = "";
  TextEditingController breedController = TextEditingController();
  String dropDownValue = "";
  List<String> listBreedURLFormat = [];
  List<String> listBreed = [];
  String selectedBreed = "Affenpinscher";
  int selectedBreedIndex = 0;

  List<TextButton> listImgWidget = [];


  //API
  String dogAPIURL = "https://dog.ceo/api/breeds/image/random";
  List imageURL = [];
// #endregion

  Text customText(String textString, double fontSize,
      [fontWeight = FontWeight.normal,
      fontColor = darkBrown,
      textHeight = 1.2]) {
    return Text(
      textString,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
          height: textHeight,
          fontFamily: 'Eczar'),
    );
  }

  SizedBox inputTextField(IconData icon_, String text_, TextInputType inputType,
      TextEditingController inputController, Function(String) onChanged_) {
    return SizedBox(
      child: TextField(
          keyboardType: inputType,
          controller: inputController,
          obscureText: false,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
              labelText: text_,
              icon: Icon(icon_,
                  size: 40, color: Colors.grey), //Add icon before textfield
              //X icon to clear inputted values
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => {
                  setState(() {
                    inputController.text = '';
                    onChanged_(
                        ''); //without this, when clearing, there exists previous set value which is never cleared
                  }),
                }, //clears the input
              )),
          onChanged:
              onChanged_), //calls function which changes the string text ie. Email, to user inputs
    );
  }

  SizedBox dropDownButton() {
    return SizedBox(
        width: 400,
        child: DropdownButton<String>(
          menuWidth: 250,
          menuMaxHeight: 300,
          isExpanded: true, //sends dropdown carrot to the foremost right
          value: selectedBreed,
          underline: Container(), //hide bottom shadow
          items: listBreed.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.normal)),
            );
          }).toList(),
          onTap: () {
            print("Tap");
          },
          onChanged: (value) {
            print("DropDown Changed");
            setState(() {
              selectedBreed = value!;
              selectedBreedIndex = listBreed.indexOf(value);
            });
          },
        ));
  }

  Future getListOfBreed() async {
    String listBreedURL = "https://dog.ceo/api/breeds/list/all";
    var response = await http.get(Uri.parse(listBreedURL));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      //Get Map["message"]
      // listOfBreed = jsonResp["message"];
      var dogBreeds = jsonResp["message"];
      List<String> tempDogBreeds = [];
      List<String> tempDogBreedsURL = [];

      for (var breed in dogBreeds.keys) {
        // print("key: $breed"); //test

        var tempList = [];
        //if dogbreed has a subname
        if (dogBreeds["$breed"].isNotEmpty) {
          tempList = dogBreeds["$breed"];
          int countTemp = tempList.length;
          // print("value: ${dogBreeds["$breed"]}"); //test

          String firstName = "";
          String lastName = "";
          for (int i = 0; i < countTemp; i++) {
            tempDogBreedsURL.add("$breed/${dogBreeds["$breed"][i]}");
            firstName = dogBreeds["$breed"][i];
            lastName = breed;
            firstName = firstName[0].toUpperCase() + firstName.substring(1);
            lastName = lastName[0].toUpperCase() + lastName.substring(1);
            tempDogBreeds.add("$firstName $lastName");
          }
        } else {
          tempDogBreedsURL
              .add(breed); //add to list of breed if it does not have subname
          String tempString = breed;
          tempString = tempString[0].toUpperCase() + tempString.substring(1);
          tempDogBreeds.add(tempString);
        }
      }

      setState(() {
        listBreedURLFormat = tempDogBreedsURL;
        listBreed = tempDogBreeds;
      });

      // print(jsonResp); //test
    } else {
      print("Error: $response.statusCode");
    }
  }

  String getSearchUrl() {
    print(selectedBreed);
    print("SelectedBreedIndex: $selectedBreedIndex");

    String tempURL =
        "https://dog.ceo/api/breed/${listBreedURLFormat[selectedBreedIndex]}/images/random/10";
    return tempURL;
  }

  Future getListOfImages() async {
    String tempURL = getSearchUrl();
    print(tempURL);
    var response = await http.get(Uri.parse(tempURL));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      setState(() {
        imageURL = jsonResp["message"];
      });
      print(imageURL); //test

      // print(jsonResp); //test
      populateImageURL();
      return imageURL;
    } else {
      print("Error: $response.statusCode");
    }
  }
  void enlargeImage(int index, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(url))),
                    ),
                    Text("URL: $url"),
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
  void populateImageURL() {
      listImgWidget.clear(); //clear widget
      setState(() {
        listImgWidget = imageURL.map<TextButton>((dynamic value) {
          return TextButton(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(value),
                fit: BoxFit.cover,
              )),
            ),
            onPressed: () {
              enlargeImage(imageURL.indexOf(value), value);
              print("IsClicked");
            },
          );
        }).toList();
    });
  }

//Initial State
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getListOfBreed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// #region TitleBar
      appBar: AppBar(
          backgroundColor: mediumBrown,
          title: Row(
            children: [
              Expanded(child: Image.asset("assets/images/paws.png")),
              customText(widget.title, 28),
              Expanded(child: Image.asset("assets/images/paws.png")),
            ],
          )),
// #endregion
      body: Container(
// #region BACKGROUND
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            //add gradient background
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [darkBrown, lightBrown])),
// #endregion
// #region MAIN
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              dropDownButton(),
              ElevatedButton(
                  onPressed: () {
                    getListOfImages();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: Colors.white),
                  child: customText("Search", 15, FontWeight.w500)),

              //Images
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
              ),
            ],
          ),
        ),
// #endregion
      ),
    );
  }
}
