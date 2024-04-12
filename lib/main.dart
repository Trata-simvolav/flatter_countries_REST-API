// 0.1.5

import 'package:flutter/material.dart';

import 'fetch_fragment.dart';
import 'detail_page.dart';
// import 'filter_header.dart';

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
  FetchElement fetchElementState = FetchElement();

  late List<dynamic> countries;
  late List<dynamic> filteredCountries;

  String dropdownValue = 'All';

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    countries = fetchElementState.futureData;
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
          TextField(
            controller: searchController,
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: InputDecoration(
              hintText: 'Search...',
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
              'America',
              'Oceania',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = filteredCountries[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 37),
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
    await Future.delayed(const Duration(seconds: 1));
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

  void filterDropdown(String continent) {
    List<String> filteredList = [];
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

  String getContinentForCountry(String country) {
    // if () {
    //   return 'Asia';
    // } else if () {
    //   return 'North America';
    // } else if () {
    //   return 'South America';
    // } else if () {
    //   return 'Europe';
    // } else if () {
    //   return 'Oceania';
    // } else {
    //   return 'Africa';
    // }

    print(country);
    if (country == 'Russia' || country == 'China' || country == 'India') {
      return 'Asia';
    } else if (country == 'United States' || country == 'Canada') {
      return 'North America';
    } else if (country == 'Brazil' || country == 'Argentina') {
      return 'South America';
    } else if (country == 'France' ||
        country == 'Germany' ||
        country == 'United Kingdom') {
      return 'Europe';
    } else if (country == 'Australia' || country == 'New Zealand') {
      return 'Oceania';
    } else {
      return 'Africa';
    }
  }
}
