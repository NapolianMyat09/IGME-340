import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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

//Create State for MyHomePage
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Color Palette for this API
  Color lightBrown = const Color(0xffe5b17f);
  Color mediumBrown = const Color(0xffc99160);
  static const Color darkBrown = Color(0xff5e3924);

  int _selectedIndex = 0; //index used to navigate between pages

  //List of Pages
  static final List<Widget> _pages = <Widget>[
    MainPage(),
    DocumentationPage(),
  ];

  ///
  ///Used in BottomNavigationBar, when tab is clicked, get the index and change _selectedIndex to new index
  ///Ultimately Changing Pages
  void _onItemTapped(int index) {
    setState(() {
      // print("Selected Index = $_selectedIndex"); //test
      _selectedIndex = index;
      // print("Tap!, Selected Index = $_selectedIndex"); //test
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TitleBar
      appBar: AppBar(
          backgroundColor: mediumBrown,
          title: Row(
            children: [
              Expanded(child: Image.asset("assets/images/paws.png")),
              customText(widget.title, 28),
              Expanded(child: Image.asset("assets/images/paws.png")),
            ],
          )),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),

      //Create a bottom navigation bar to navigate between main content page and documentation page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mediumBrown,
        items: const <BottomNavigationBarItem>[
          //HomePage Tab
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Main",
          ),
          //Documentation Page Tab
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Documentation",
          ),
        ],
        currentIndex: _selectedIndex, //what index the current page is at
        selectedItemColor: Colors.white, //the page selected color indication
        onTap: _onItemTapped, //when clicked, call this function
      ),
    );
  }
}

//Create State for MainPage
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //VARIABLES
  //Color Palette for this API
  static const Color lightBrown = Color(0xffe5b17f);
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

  List<Container> listImgWidget = [];
  List<String> savedImagesPreset = [];
  int? _selectedSearchCount;
  int? displayCount = 0;
  List<int> numberList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ]; //dropdown number list
  List<DropdownMenuItem> numberDropdown = [];

  //API
  String dogAPIURL = "https://dog.ceo/api/breeds/image/random";
  String dogAPIURLRand = "https://dog.ceo/api/breeds/image/random";
  List imageURL = [];

  //pref
  late SharedPreferences myPrefs;

  ///Return displayImageType
  String displayImageType = "";

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

  ///
  ///DropDownButton for list of breeds of dogs
  ///
  SizedBox dropDownButton() {
    return SizedBox(
        width: 400,
        child: DropdownSearch<String>(
          items: listBreed,
          selectedItem: valueBreedName(),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
            ),
          ), //remove border outline
          popupProps: const PopupProps.menu(
            menuProps: MenuProps(
                backgroundColor: lightBrown, shadowColor: Colors.black),
            showSearchBox: true,
          ),
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
      print(jsonResp["message"]);
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

    return "https://dog.ceo/api/breed/${listBreedURLFormat[selectedBreedIndex]}/images/random/$_selectedSearchCount";
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
        displayCount = imageURL.length;
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
                    TextButton(
                      child: Text("URL: $url"),
                      onPressed: () async {
                        Uri myUrl = Uri.parse(url);
                        if (!await launchUrl(myUrl,
                            mode: LaunchMode.inAppWebView)) {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
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
                            Navigator.pop(context);
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
                            } else {}
                            saveImages();
                            Navigator.pop(context);
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
      listImgWidget = listImageURL.map<Container>((dynamic value) {
        //create a container so that the image that is populated shows up more uniform
        return Container(
          color: darkBrown, //change container color to theme
          child: imgPopUp(
              value), //call upo function that creates a textbutton for each picture
        );
      }).toList();
      displayCount = listImgWidget.length;
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
  /// Save All Data
  ///
  Future saveData() async {
    await myPrefs.setInt("breedIndex", selectedBreedIndex);
    await myPrefs.setInt("counter", _selectedSearchCount!);
  }

  ///
  ///Save Pictures of Dog
  ///
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
        _selectedSearchCount = tempCounter;
      }
      if (tempSavedList != null) {
        savedImagesPreset = tempSavedList;
      }
    });
  }

  ///
  ///Does this on app load
  ///
  Future init() async {
    myPrefs = await SharedPreferences.getInstance();
    getRandImage();

    await restoreData();
  }

//Initial State
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getListOfBreed();
      getRandImage();
    });
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
// #region BACKGROUND
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
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
          children: <Widget>[
            //Dog Breed Widget
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      //Dog Breed Title
                      SizedBox(height: 25, child: customText("Dog Breed", 20)),
                      dropDownButton(),
                      SizedBox(
                          height: 25, child: customText("Display Amount", 20)),
                      DropdownSearch<int>(
                        items: numberList,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ), //remove border outline
                        popupProps: const PopupProps.menu(
                          menuProps: MenuProps(
                            backgroundColor: lightBrown,
                          ),
                        ),
                        selectedItem: _selectedSearchCount,
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedSearchCount = newValue;
                          });
                        },
                      ),
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

            const SizedBox(
              height: 10,
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
                    setState(() {
                      displayImageType = "Searched Images";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: darkBrown),
                  child: customText("Search", 15, FontWeight.w500, lightBrown),
                ),
                //Load Saved Images
                ElevatedButton(
                  onPressed: () async {
                    populateImageURL(savedImagesPreset);
                    await saveData();
                    setState(() {
                      displayImageType = "Saved Images";
                    });
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
                  child: customText("Random", 15, FontWeight.w500, lightBrown),
                ),
              ],
            ),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Type: $displayImageType"),
                  Text("Results Found: $displayCount")
                ],
              ),
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
    );
  }
}

///
///Page Created For Documentation
///
class DocumentationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          child: Column(children: [
        Text(
          "This project is an API-based application designed to showcase the aesthetics of various dog breeds through images. The app is portrait-oriented and features a theme based on a spectrum of the color brown.",
        ),
        Text("Key Features:"),
        Text(
            "1.	Automatic Image Display:\nUpon loading, the app automatically displays a random picture of any dog breed. This feature ensures that users are greeted with a fresh and engaging image each time they open the app."),
        Text(
            "\n2.	Search Functionality:\nUsers can search for specific dog breeds and specify the number of images they want to be generated. This functionality is inspired by Gif Finder, which simplifies the process of finding and displaying multiple images."),
        Text(
            "\n3.	Challenges and Solutions:\n\ta.	Dog CEO API Integration:\nThe Dog CEO website's documentation lacked specifics on URL formatting, leading to initial difficulties. After multiple debugging sessions, I figured out that the HTTP URL returns a complex map structure, with the needed information nested within segments or another map.\n\tb.	Breed List Formatting:\nThe Dog CEO API lists breeds and sub-breeds in a reversed format (e.g., 'greyhound Italian' instead of 'Italian Greyhound'). To make this more user-friendly for English speakers, I had to swap the names and ensure proper capitalization for aesthetic purposes.\n\tc.	Image Quantity Search:\nAlthough the Dog CEO API supports searching for a specific number of images, this feature was not well-documented. Through trial and error, I discovered this option and implemented it, avoiding the need for a for loop."),
        Text(
            "\n4.	User Interface Enhancements:\na.	Image Count Slider:\nInitially, I implemented a slider for users to select the number of images to load. However, this feature did not look right and took a considerable amount of time to implement. I eventually reverted to a dropdown menu for simplicity and aesthetic satisfaction.\nb.	Image Container:\nInitially, images were displayed without a container, leading to a disorganized appearance. Based on user feedback, I added a container to make the images more uniform and visually appealing.\nc.	Save and Delete Buttons:\nThe save and delete buttons lacked visual feedback, making it unclear whether the actions were successful. I implemented Navigator.pop() to close the action, providing users with a clear indication that their action was completed."),
        Text(
            "\n5.	Additional Features:\na.	Dropdown Search Package:\nUsers expressed dissatisfaction with the dropdown search package, as it required manual scrolling to find a breed. I made adjustments to improve the search functionality, allowing for quicker and more efficient breed selection.\nb.	Saved Preferences:nUsers can save their search options and individually saved images. These preferences can be reloaded with a button click or upon restarting the app, enhancing user convenience.\nc.	Image Details Popup:\nWhen users click on a dog image, a popup appears with more details, including the URL to the image. Users can click on the URL to view the image on the web, providing additional context and information.\nd.	Pages\nI was able to create a page for the app and another page for the documentation. I had trouble with this as the class lectures doesn’t go into depth how to implement this. Looking through YouTube videos and experimenting, I was able to implement this."),
      ])),
    ));
  }
}
