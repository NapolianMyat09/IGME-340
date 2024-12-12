import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  String randImageURL = "";
  List<TextButton> listImgWidget = [];
  List<String> savedImagesPreset = [];

  //API
  String dogAPIURL = "https://dog.ceo/api/breeds/image/random";
  String dogAPIURLRand = "https://dog.ceo/api/breeds/image/random";
  List imageURL = [];
// #endregion
  TextEditingController counterTermController = TextEditingController();
  int _counter = 1;
  int maxCounter = 20;

  //pref
  late SharedPreferences myPrefs;

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter > maxCounter) {
        _counter = maxCounter;
      }
      counterTermController.text = _counter.toString();
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter <= 0) {
        _counter = 1;
      }
      counterTermController.text = _counter.toString();
    });
  }

  ///
  /// Friendly Text Formatter,
  /// based on the string, fontsize, fontweight, fontcolor, textHeight, alignment
  ///
  Text customText(String textString, double fontSize,
      [fontWeight = FontWeight.normal,
      fontColor = darkBrown,
      textHeight = 1.2,
      TextAlign alignment = TextAlign.center]) {
    return Text(
      textString,
      textAlign: alignment,
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

  ///
  ///For Saving purposes
  ///Get the breedName of the saved image
  ///
  String valueBreedName() {
    if (listBreed.isNotEmpty) {
      breedName = listBreed[selectedBreedIndex];
    }
    return breedName;
  }

  ///DropDownButton for list of breeds of dogs
  SizedBox dropDownButton() {
    return SizedBox(
        width: 400,
        child: DropdownButton<String>(
          menuWidth: 250,
          menuMaxHeight: 300,
          isExpanded: true, //sends dropdown carrot to the foremost right
          value: valueBreedName(),
          underline: Container(), //hide bottom shadow
          items: listBreed.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.normal)),
            );
          }).toList(),
          onTap: () {
            // print("Tap");
          },
          onChanged: (value) {
            // print("DropDown Changed");
            setState(() {
              selectedBreed = value!;
              selectedBreedIndex = listBreed.indexOf(value);
            });
          },
        ));
  }

  ///
  /// Get list of breed searched
  ///
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

  ///
  ///Get the search url users formated, based on the selected breed and how many they want displayed
  String getSearchUrl() {
    // print(selectedBreed);
    // print("SelectedBreedIndex: $selectedBreedIndex");

    return "https://dog.ceo/api/breed/${listBreedURLFormat[selectedBreedIndex]}/images/random/$_counter";
  }

  ///
  ///Get 1 random picture of any breed of dog
  ///
  Future getRandImage() async {
    var response = await http.get(Uri.parse(dogAPIURLRand));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);
      setState(() {
        randImageURL = jsonResp["message"];
      });

      // print(jsonResp); //test
    } else {
      print("Error: $response.statusCode");
    }
  }

  ///
  /// Get Search term and display amount List
  ///
  Future getListOfImages() async {
    String tempURL = getSearchUrl();
    // print(tempURL);
    var response = await http.get(Uri.parse(tempURL));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      setState(() {
        imageURL = jsonResp["message"];
      });
      // print(imageURL); //test

      // print(jsonResp); //test
      populateImageURL(imageURL);
      return imageURL;
    } else {
      print("Error: $response.statusCode");
    }
  }

  ///
  ///Split url string to get specific breed name for enlarge Display use
  ///
  String getBreedName(url) {
    List<String> segments = url.split('/');
    String breed = segments[
        4]; //4 is fixed as this is where the name is located in the url
    String firstName;
    String lastName;
    List<String> breedWith2NameException = segments[4].split('-');
    if (breedWith2NameException.length != 1) {
      firstName = breedWith2NameException[1];
      lastName = breedWith2NameException[0];
      firstName = firstName[0].toUpperCase() + firstName.substring(1);
      lastName = lastName[0].toUpperCase() + lastName.substring(1);
      breed = "$firstName $lastName";
    } else {
      breed = breedWith2NameException[0][0].toUpperCase() +
          breedWith2NameException[0].substring(1);
    }

    //Capitalize the first.
    return breed;
  }

  ///
  ///Popup Bigger image
  ///
  void enlargeImage(int index, String url) {
    String thisBreed = getBreedName(url);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: lightBrown,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    customText(
                        "Breed: $thisBreed", 24, FontWeight.bold, Colors.black),
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(url))),
                    ),
                    Text("URL: $url"),
                    //close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(darkBrown),
                            foregroundColor:
                                WidgetStateProperty.all(lightBrown),
                          ),
                          child: const Text("Close"),
                        ),
                        //Save button
                        ElevatedButton(
                          onPressed: () {
                            if (!savedImagesPreset.contains(
                                url)) //only add if list does not already contain saved image
                            {
                              savedImagesPreset.add(url);
                            }
                            saveImages();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(darkBrown),
                            foregroundColor:
                                WidgetStateProperty.all(lightBrown),
                          ),
                          child: const Text("Save"),
                        ),
                        //Delete Button
                        ElevatedButton(
                          onPressed: () {
                            if (savedImagesPreset.contains(url)) {
                              savedImagesPreset.remove(url);
                            }
                            saveImages();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(darkBrown),
                            foregroundColor:
                                WidgetStateProperty.all(lightBrown),
                          ),
                          child: const Text("Delete"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  ///Add imgURL into list of widgets
  ///
  void populateImageURL(List listImageURL) {
    listImgWidget.clear(); //clear widget
    setState(() {
      listImgWidget = listImageURL.map<TextButton>((dynamic value) {
        return imgPopUp(value);
      }).toList();
    });
  }

  ///
  ///Display Images of Dogs searched
  ///
  TextButton imgPopUp(urlValue) {
    return TextButton(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(urlValue),
          fit: BoxFit.contain,
        )),
      ),
      onPressed: () {
        enlargeImage(imageURL.indexOf(urlValue), urlValue);
        // print("IsClicked");
      },
    );
  }

  ///
  /// Save Pictures of Dog
  ///
  Future saveData() async {
    await myPrefs.setInt("breedIndex", selectedBreedIndex);
    await myPrefs.setInt("counter", _counter);
  }

  Future saveImages() async {
    await myPrefs.setStringList("savedImages", savedImagesPreset);
  }

  ///
  /// Load Saved Pictures of Dogs
  ///
  Future restoreData() async {
    setState(() {
      int? tempBreedIndex = myPrefs.getInt("breedIndex");
      int? tempCounter = myPrefs.getInt("counter");
      List<String>? tempSavedList = myPrefs.getStringList("savedImages");

      if (tempBreedIndex != null) {
        selectedBreedIndex = tempBreedIndex;
      }
      if (tempCounter != null) {
        _counter = tempCounter;
        counterTermController.text = _counter.toString();
      }
      if (tempSavedList != null) {
        savedImagesPreset = tempSavedList;
      }
    });
  }

//Initial State
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getListOfBreed();
      counterTermController.text = _counter.toString();
      getRandImage();
    });
    init();
  }

  ///
  ///Does this on app load
  ///
  Future init() async {
    myPrefs = await SharedPreferences.getInstance();
    getRandImage();

    await restoreData();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Dog Breed Widget

              //Increment/Decrement Widget
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 25, child: customText("Dog Breed", 20)),
                        dropDownButton(),
                        SizedBox(
                            height: 25,
                            child: customText("Display Amount", 20)),
                        Row(children: [
                          FloatingActionButton(
                            onPressed: _decrementCounter,
                            tooltip: 'Decrement',
                            backgroundColor: darkBrown,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.exposure_minus_1),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: counterTermController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  //Check if the displayed is null, auto result back to 1
                                  if (int.tryParse(
                                          counterTermController.text) ==
                                      null) {
                                    _counter = 1;
                                    counterTermController.text =
                                        _counter.toString();
                                  }
                                  if (int.tryParse(
                                          counterTermController.text)! >
                                      maxCounter) {
                                    _counter = maxCounter;
                                    counterTermController.text =
                                        _counter.toString();
                                  }
                                });
                              },
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: _incrementCounter,
                            tooltip: 'Increment',
                            backgroundColor: darkBrown,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.exposure_plus_1),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                      color: darkBrown,
                      width: 200,
                      height: 200,
                      child: imgPopUp(randImageURL)),
                ],
              ),
              //Search Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Search Button
                  ElevatedButton(
                    onPressed: () async {
                      getListOfImages();
                      await saveImages();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: darkBrown),
                    child:
                        customText("Search", 15, FontWeight.w500, lightBrown),
                  ),
                  //Load Saved Images
                  ElevatedButton(
                    onPressed: () async {
                      populateImageURL(savedImagesPreset);
                      await saveData();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: lightBrown),
                    child: customText(
                        "Load Saved Images", 15, FontWeight.w500, darkBrown),
                  ),
                  //Random Button
                  ElevatedButton(
                    onPressed: () {
                      getRandImage();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: darkBrown),
                    child:
                        customText("Random", 15, FontWeight.w500, lightBrown),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //Images
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(10),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
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
      //Create a bottom navigation bar to navigate between main content page and documentation page
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.description)),
      ]),
    );
  }
}
