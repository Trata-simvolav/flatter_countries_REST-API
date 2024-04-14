// 0.2.0

import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

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
                    255, 48, 48, 48), // Задаем зеленый цвет как secon1111☺dary
                background: Color.fromARGB(255, 39, 39, 39),
              ),
            )
          : ThemeData(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(
                    255, 255, 255, 255), // Задаем голубой цвет как primary
                secondary: Color.fromARGB(255, 214, 214, 214),
                background: Color.fromARGB(255, 234, 234, 234),
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
  List<dynamic> countries = [];
  List<dynamic> filteredCountries = [];

  String dropdownValue = 'All';

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    fetchCountries();
    super.initState();
  }

  Future<void> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        countries = data;
        filteredCountries = countries;
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "WHERE MY SOCS",
          style: TextStyle(
            color: invertedColor(Theme.of(context).colorScheme.primary),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.lightbulb_outline,
              color: invertedColor(Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              final _MyAppState? state =
                  context.findAncestorStateOfType<_MyAppState>();
              state?.toggleDarkMode();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
                filled: true,
                fillColor: const Color.fromARGB(255, 202, 202, 202),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                filterDropdown(newValue);
                print(
                    newValue); // ------------------------------------------------------------------------------------------------------
              });
            },
            items: <String>[
              'All',
              'Africa',
              'Asia',
              'Europe',
              'Americas',
              'Oceania',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: Future.delayed(const Duration(milliseconds: 500), () {
                return filteredCountries;
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<dynamic> futureDataList = snapshot.data!;
                  return ListView.builder(
                    itemCount: futureDataList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = futureDataList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 37),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SecondPage(
                                    item: item, countries: countries),
                              ),
                            );
                          },
                          child: Card(
                            color: Theme.of(context).colorScheme.surface,
                            shadowColor: Colors.black.withOpacity(0.5),
                            elevation: 5,
                            margin: const EdgeInsets.all(8),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 310,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
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
          ),
        ],
      ),
    );
  }

  Color invertedColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  void filterSearchResults(String query) async {
    List<dynamic> searchResults = [];
    if (query.isNotEmpty) {
      for (var country in countries) {
        if (country['name']['common']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          searchResults.add(country);
        }
      }
    } else {
      searchResults = countries;
    }
    setState(() {
      filteredCountries = searchResults;
    });
  }

  void filterDropdown(String continent) async {
    List<dynamic> filteredList = [];
    if (continent == 'All') {
      filteredList = countries;
    } else {
      countries.forEach((country) {
        if (getContinentForCountry(country) == continent) {
          filteredList.add(country);
        }
      });
    }
    setState(() {
      filteredCountries = filteredList;
    });
  }

  String getContinentForCountry(var country) {
    if (country['region'] == 'Asia') {
      return 'Asia';
    } else if (country['region'] == 'Americas') {
      return 'Americas';
    } else if (country['region'] == 'Europe') {
      return 'Europe';
    } else if (country['region'] == 'Oceania') {
      return 'Oceania';
    } else {
      return 'Africa';
    }
  }
}
