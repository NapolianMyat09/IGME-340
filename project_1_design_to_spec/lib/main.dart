import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Trees & Wood'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //TextStyles
  TextStyle _itemTextStyle(
      Color fontColor, double customFontSize, double textHeight,
      [FontWeight fontWeight = FontWeight.normal]) {
    return TextStyle(
      fontFamily: 'VT323',
      color: fontColor,
      fontSize: customFontSize,
      height: textHeight,
      fontWeight: fontWeight,
    );
  }

  TextStyle _retroComputer(
      Color fontColor, double fontSize, double textHeight, FontWeight bold) {
    return TextStyle(
        fontFamily: 'RetroComputer',
        color: fontColor,
        fontSize: fontSize,
        height: textHeight,
        fontWeight: bold);
  }

  TextButton _individualItems(
      String imgFileName, String itemName, String itemText,
      [String description =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"]) {
    return TextButton(
      onPressed: () {
        _itemDialog(itemName, imgFileName, description);
      },
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            //Image
            _styleImage(itemName, imgFileName, 150),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                color: Color(0xFF686868),
                width: 220,
                height: 200,
                child: SingleChildScrollView(
                    child: Text(itemText,
                        style: _itemTextStyle(Colors.white, 20, 1.2))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _styleImage(String itemName, String imgFileName, double _width) {
    return Container(
      width: 150,
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFFFFFFF),
          width: 6.0,
        ),
        color: const Color(0xFF324E44),
      ),
      //Plank Inside Box
      child: Column(
        children: [
          Text(
            itemName,
            style: _itemTextStyle(Colors.white, 24, 1.2),
          ),
          Image.asset(
            imgFileName,
            height: 89,
            width: 100,
          ),
        ],
      ),
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: AlertDialog(
            title: Text(
                "About\n\nCreated by Napolian Myat\n\nBased on the work done in 235's Design to Spec Homework.\n\nSeptember 6, 2024",
                style: _itemTextStyle(Colors.black, 20, 1.2, FontWeight.w100)),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(0, 143, 145, 144)),
                ),
                child: Text(
                  "OK",
                  style: _itemTextStyle(Colors.black, 20, 1.2, FontWeight.w100),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _itemDialog(String itemName, String imgFileName, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: AlertDialog(
            backgroundColor: Color(0xFF686868),
            title: Text(itemName,
                style: _itemTextStyle(Colors.white, 24, 1.2, FontWeight.w100)),
            actions: [
              //Image
              Container(
                width: 300,
                height: 260,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFFFFFFF),
                    width: 6.0,
                  ),
                  color: const Color(0xFF324E44),
                ),
                //Plank Inside Box
                child: Column(
                  children: [
                    Image.asset(
                      imgFileName,
                      height: 230,
                      width: 240,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Text(
                      description,
                      style: _itemTextStyle(Colors.black, 20, 1.2),
                    ),
                  ),
                ),
              ),

              //Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(200, 205, 212, 208)),
                ),
                child: Text(
                  "Close",
                  style: _itemTextStyle(Colors.black, 20, 1.2, FontWeight.w100),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/pickaxe.svg',
                  height: 35,
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  widget.title,
                  style:
                      _retroComputer(Colors.white, 24, 1.2, FontWeight.normal),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                _showDialog();
              },
              child:
                  const Icon(Icons.account_circle_rounded, color: Colors.black),
            ),
          ],
        ),
      ),
      body: SizedBox(
        //background img
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/valley.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
              child: Column(
            children: [
              //OakTree Image
              Container(
                //Padding edge color white
                height: 400,
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFFFFFFF),
                    width: 7.0,
                  ),
                  color: const Color(0xFF324E44),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                      Color(0x244D3E).withAlpha(255),
                      Color(0xE8FDF5).withAlpha(255),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Image.asset(
                  'assets/images/oaktree.png',
                ),
              ),
              //OakTree Text
              Container(
                height: 500,
                padding: const EdgeInsets.all(10.0),
                color: const Color(0xFF686868),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'The Oak Tree',
                        style: _retroComputer(
                            Colors.white, 24, 1.2, FontWeight.bold),
                      ),
                    ),
                    Text(
                      "\nLorem ipsum dolor sit amet, consectetur adipiscing elit. \n\nVestibulum consequat elementum ligula, quis mattis sem ultrices et. Nam eleifend iaculis arcu, et posuere quam ultricies at. In interdum purus sem, ac varius odio elementum vitae. Nullam et blandit dui, ut porttitor erat. Donec vitae risus commodo, mollis tellus sit amet, suscipit leo. \n\nSuspendisse vulputate quam arcu, sollicitudin maximus ex finibus et. Aliquam erat volutpat. Aliquam eu arcu a nisl rhoncus tristique et ac eros. Nulla quis euismod nisl. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse potenti.",
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 1.0),
                    )
                  ],
                ),
              ),
              //BlankBox
              const SizedBox(
                height: 400,
              ),

              //Item List
              Container(
                height: 680,
                color: const Color(0xFF35363D),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Planks
                    _individualItems(
                      "assets/images/planks.png",
                      "Planks",
                      "Planks are common blocks used as building blocks and in crafting recipes. They are one of the first things that a player can craft in",
                    ),

                    //Sticks
                    _individualItems(
                      "assets/images/stick.png",
                      "Stick",
                      "A stick is an item used for crafting many tools and items.",
                    ),

                    //Chests
                    _individualItems(
                      "assets/images/chest.png",
                      "Chests",
                      "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                    ),

                    //Stairs
                    _individualItems(
                      "assets/images/stairs.png",
                      "Stairs",
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. ",
                    ),
                  ],
                ),
              ),

              //BlankScreen
              Container(height: 10, color: Colors.white),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/trees.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  width: 400,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trees are pretty cool, right?",
                          style: _retroComputer(
                              Colors.white, 24, 1.2, FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Copyright 2022 RIT School of Interactive Games and Media",
                          style: _retroComputer(
                              Colors.white, 20, 1.2, FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                ),
              ),
            ],
          )),
        ),

        //other stuff
      ),
    );
  }
}
