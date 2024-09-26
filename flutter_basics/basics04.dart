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
            Column(children: [
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.red,
                  child: const Center(child: Text("Item 01")))),
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.orange,
                  child: const Center(child: Text("Item 02")))),
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.yellow,
                  child: const Center(child: Text("Item 03")))),
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.green,
                  child: const Center(child: Text("Item 04")))),
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.blue,
                  child: const Center(child: Text("Item 05")))),
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.indigo,
                  child: const Center(child: Text("Item 06")))),
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.purple,
                  child: const Center(child: Text("Item 07")))),
          Expanded(
              child: Container(
                  height: 200,
                  color: Colors.grey,
                  child: const Center(child: Text("Item 08"))))
        ]));
  }
}
