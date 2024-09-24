import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //3.)Add a scaffoldBackgroundColor to both light and dark themes.
      theme: ThemeData(
        //13.) Alter the default font of the theme to Courier.
        fontFamily: 'Courier',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        //3.)light background to grey[300].
        scaffoldBackgroundColor: Colors.grey[300],
        //TextTheme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 48,
            fontWeight: FontWeight.w900,
          ),
          displayMedium: TextStyle(
            color: Color.fromARGB(255, 68, 0, 255),
            fontSize: 44,
            fontWeight: FontWeight.w800,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 80, 0, 146),
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Color.fromARGB(255, 0, 75, 40),
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 125, 0, 0),
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            color: Colors.brown,
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Colors.black,
            ),
            foregroundColor: WidgetStateProperty.all(
              const Color.fromARGB(255, 80, 0, 146),
            ),
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      //2.) Add a darkTheme to the MaterialApp, and
      darkTheme: ThemeData(
        //2b.)apply a new color scheme based on a seed color of red.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        //3.) Set the dark background to blueGrey[500]
        scaffoldBackgroundColor: Colors.blueGrey[500],
        //TextTheme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w900,
          ),
          displayMedium: TextStyle(
            color: Color.fromRGBO(122, 255, 34, 1),
            fontSize: 44,
            fontWeight: FontWeight.w800,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 242, 255, 0),
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Color.fromARGB(255, 49, 95, 248),
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 255, 0, 0),
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            color: Color.fromARGB(255, 246, 78, 255),
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              const Color.fromRGBO(122, 255, 34, 1),
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),

      //1.) Add a themeMode attribute to your MaterialApp and set it to light.
      themeMode: ThemeMode.light,

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
        title: const Text("IGME-340: Themes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //12.) Create an ElevatedButton with an icon.
            ElevatedButton.icon(
              onPressed: () {
                print("ElevatedButton With Icon Pressed");
              },
              icon: const Icon(Icons.add_a_photo),
              label: const Text(
                "Add a Photo",
                style: TextStyle(fontSize: 14),
              ),
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
            ),
            //10.) Add a, TextButton and OutlinedButton
            TextButton(
              onPressed: () {
                print("TextButton Pressed");
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 28, 138, 92)),
                foregroundColor:
                    WidgetStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
              ),
              child: const Text(
                "Text Button",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 206, 130, 0)),
                foregroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 200, 255, 0)),
              ),
              child: const Text(
                "Text Button",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: 300,
              height: 200,
              //4.) Change the colors of container to material theme colors => green to primary
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                "I am Primary",
                //Change each container's text to a different textTheme,
                //observe the changes when the app reloads.
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              width: 200,
              height: 200,
              //4.) yellow to secondary
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                "I am Secondary",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              width: 350,
              height: 100,
              //4.) pink to error
              color: Theme.of(context).colorScheme.error,
              child: Text(
                "I am Error",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("ElevatedButton1 Pressed");
              },
              child: const Text('Elevated Button'),
            ),
            //7.) Add another ElevatedButton
            ElevatedButton(
              onPressed: () {
                print("ElevatedButton2 Pressed");
              },
              child: const Text(
                'Elevated2 Button',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
