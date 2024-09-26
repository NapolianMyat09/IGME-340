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
            Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: 100,
              color: Colors.orange,
              child: const Center(child: Text("Item 01")),
            ),
            Container(
              height: 250,
              width: 100,
              color: Colors.red,
              child: const Center(child: Text("Item 02")),
            ),
            Container(
              height: 150,
              width: 100,
              color: Colors.blue,
              child: const Center(child: Text("Item 03")),
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.greenAccent,
              child: const Center(child: Text("Item 04")),
            )
          ],
        ));
  }
}
