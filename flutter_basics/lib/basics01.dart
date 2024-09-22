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
          title: const Text("IGME-340 Basic App",
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body:
            //add a Column Widget
            Column(
          mainAxisAlignment: MainAxisAlignment
              .end, //change the flow of the container to the bot
          children: [
            //Add 4 Containers
            //Height and Width of 150 pixels.
            //Contain Text that is centered with something identifying each Container.
            //Each should be uniquely colored.
            Container(
              height: 150,
              width: 150,
              color: Colors.orange,
              child: const Center(child: Text("Item 01")),
            ),
            Container(
              height: 150,
              width: 150,
              color: Colors.red,
              child: const Center(child: Text("Item 02")),
            ),
            Container(
              height: 150,
              width: 150,
              color: Colors.blue,
              child: const Center(child: Text("Item 03")),
            ),
            Container(
              height: 150,
              width: 150,
              color: Colors.greenAccent,
              child: const Center(child: Text("Item 04")),
            )
          ],
        ));
  }
}
