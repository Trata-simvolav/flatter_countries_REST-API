// 0.0.13

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detailPage.dart';

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
                primary: Color.fromARGB(255, 25, 25, 25),
                secondary: Color.fromARGB(255, 53, 53, 53),
                background: Color.fromARGB(255, 74, 74, 74),
              ),
            )
          : ThemeData(
              colorScheme: const ColorScheme.dark(
                primary: Color.fromARGB(255, 255, 255, 255),
                secondary: Color.fromARGB(255, 247, 247, 247),
                background: Color.fromARGB(255, 240, 240, 240),
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
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchPost();
  }

  Future<List<dynamic>> fetchPost() async {
    final response =
        await http.get(Uri.parse("https://restcountries.com/v3.1/all"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "WHERE MY SOCS",
          style: TextStyle(
              color: invertedColor(Theme.of(context).colorScheme.primary)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb_outline,
                color: invertedColor(Theme.of(context).colorScheme.primary)),
            onPressed: () {
              final _MyAppState? state =
                  context.findAncestorStateOfType<_MyAppState>();
              state?.toggleDarkMode();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> data = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = data[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 9.0,
                    bottom: 8.0,
                    left: 37.0,
                    right: 37.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondPage(item: item),
                        ),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.background,
                      shadowColor: Colors.black.withOpacity(0.5),
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 310,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                    15.0), // радиус левого верхнего угла
                                topRight: Radius.circular(
                                    15.0), // радиус правого верхнего угла
                              ),
                              child: Image.network(
                                '${item['flags']['png']}',
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: const SizedBox(height: 160),
                            subtitle: Row(
                              children: [
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name']['common'],
                                        style: TextStyle(
                                            color: invertedColor(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Population: ${item['population']}',
                                        style: TextStyle(
                                            color: invertedColor(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Region: ${item['region']}',
                                        style: TextStyle(
                                            color: invertedColor(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Capital: ${item['capital'][0]}',
                                        style: TextStyle(
                                            color: invertedColor(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Color invertedColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
