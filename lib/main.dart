// 0.0.4

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData(
              colorScheme: const ColorScheme.dark(
                primary: Color.fromARGB(
                    255, 31, 31, 31), // Задаем голубой цвет как primary
                secondary: Color.fromARGB(
                    255, 48, 48, 48), // Задаем зеленый цвет как secondary
              ),
            )
          : ThemeData(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(
                    255, 255, 255, 255), // Задаем голубой цвет как primary
                secondary: Color.fromARGB(
                    255, 214, 214, 214), // Задаем зеленый цвет как secondary
              ),
            ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Where in the world?"),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () {
              final _MyAppState? state =
                  context.findAncestorStateOfType<_MyAppState>();
              state?.toggleDarkMode();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
