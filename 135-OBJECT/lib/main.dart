import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search and Filter Example',
      home: SearchFilterPage(),
    );
  }
}

class SearchFilterPage extends StatefulWidget {
  @override
  _SearchFilterPageState createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  List<String> countries = [];
  List<String> filteredCountries = [];

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
        countries =
            data.map<String>((country) => country['name']['common']).toList();
        filteredCountries = countries;
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search and Filter Example'),
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
              });
            },
            items: <String>[
              'All',
              'Africa',
              'Asia',
              'Europe',
              'North America',
              'Oceania',
              'South America'
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
                return ListTile(
                  title: Text(filteredCountries[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    List<String> searchResults = [];
    if (query.isNotEmpty) {
      countries.forEach((country) {
        if (country.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(country);
        }
      });
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
    // Simulate getting continent information from country data
    // You might need to replace this with actual logic based on your API response structure
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
