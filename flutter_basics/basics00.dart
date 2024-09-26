import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IGME-340 Basic App"),
      ),
      body:
          //2.) Wrap the Container in an Align Widget
          Align(
              //and position the Container in the center.
              alignment: Alignment.center,
              child: Container(
                //1.) give it a height and width of 200 pixels
                height: 200,
                width: 200,
                color: Colors.red,
              )),
    );
  }
}
