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
  final TextStyle itemTextStyle = TextStyle(
    fontFamily: 'VT323',
    color: Colors.white,
    fontSize: 20,
    height: 1.2,
  );
  final TextStyle capTextStyle = TextStyle(
    fontFamily: 'RetroComputer',
    color: Colors.white,
    fontSize: 24,
    height: 1.2,
  );
  final TextStyle capTextStyleSmall = TextStyle(
    fontFamily: 'RetroComputer',
    color: Colors.white,
    fontSize: 20,
    height: 1.2,
  );
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
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
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontFamily: 'RetroComputer',
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
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
                child: const Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'The Oak Tree',
                        style: TextStyle(
                            fontFamily: 'RetroComputer',
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
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
                height: 700,
                width: double.infinity,
                color: const Color(0xFF35363D),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.all(0.0)),

                    //Planks
                    SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          //add padding between each item
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                          //Plank Image
                          Container(
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
                                  'Planks',
                                  style: TextStyle(
                                    fontFamily: 'VT323',
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/planks.png',
                                  height: 89,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            color: Color(0xFF686868),
                            width: 220,
                            height: 200,
                            child: Text(
                                "Planks are common blocks used as building blocks and in crafting recipes. They are one of the first things that a player can craft in",
                                style: itemTextStyle),
                          ),
                        ],
                      ),
                    ),

                    //Sticks
                    SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          //add padding between each item
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                          //Stick Image
                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFFFFFFF),
                                width: 6.0,
                              ),
                              color: const Color(0xFF324E44),
                            ),
                            //stick Inside Box
                            child: Column(
                              children: [
                                Text(
                                  'Stick',
                                  style: TextStyle(
                                    fontFamily: 'VT323',
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/stick.png',
                                  height: 89,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            color: Color(0xFF686868),
                            width: 220,
                            height: 200,
                            child: Text(
                                "A stick is an item used for crafting many tools and items.",
                                style: itemTextStyle),
                          ),
                        ],
                      ),
                    ),

                    //Chests
                    SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          //add padding between each item
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                          //Chests Image
                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFFFFFFF),
                                width: 6.0,
                              ),
                              color: const Color(0xFF324E44),
                            ),
                            //Chests Inside Box
                            child: Column(
                              children: [
                                Text(
                                  'Chests',
                                  style: TextStyle(
                                    fontFamily: 'VT323',
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/chest.png',
                                  height: 89,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            color: Color(0xFF686868),
                            width: 220,
                            height: 200,
                            child: Text(
                                "Planks are common blocks used as building blocks and in crafting recipes. They are one of the first things that a player can craft in",
                                style: itemTextStyle),
                          ),
                        ],
                      ),
                    ),

                    //Stairs
                    SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          //add padding between each item
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                          //Stair Image
                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFFFFFFF),
                                width: 6.0,
                              ),
                              color: const Color(0xFF324E44),
                            ),
                            //Stair Inside Box
                            child: Column(
                              children: [
                                Text(
                                  'Stairs',
                                  style: TextStyle(
                                    fontFamily: 'VT323',
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/stairs.png',
                                  height: 89,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            color: Color(0xFF686868),
                            width: 220,
                            height: 200,
                            child: Text(
                                "Planks are common blocks used as building blocks and in crafting recipes. They are one of the first things that a player can craft in",
                                style: itemTextStyle),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //BlankScreen
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/trees.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  width: 400,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trees are pretty cool, right?",
                          style: capTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Copyright 2022 RIT School of Interactive Games and Media",
                          style: capTextStyleSmall,
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
