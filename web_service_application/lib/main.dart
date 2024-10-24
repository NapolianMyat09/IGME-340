import 'package:flutter/material.dart';

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
  //Variables
  //Color Palette for this API
  Color lightBrown = const Color(0xffe5b17f);
  Color mediumBrown = const Color(0xffc99160);
  static const Color darkBrown = Color(0xff5e3924);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mediumBrown,
          title: Row(
            children: [
              Expanded(child: Image.asset("assets/images/paws.png")),
              customText(widget.title, 28),
            ],
          )),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: lightBrown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
