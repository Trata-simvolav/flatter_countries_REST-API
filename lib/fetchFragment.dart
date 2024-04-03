// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

// ignore: must_be_immutable
class FetchElement extends StatefulWidget {
  FetchElement({super.key});

  @override
  _FetchElementState createState() => _FetchElementState();

  _FetchElementState fetchElementState = new _FetchElementState();
  Future<List<dynamic>> get futureData => fetchElementState.fetchPost();
}

class _FetchElementState extends State<FetchElement> {
  late Future<List<dynamic>> futureDataList;

  @override
  void initState() {
    super.initState();
    futureDataList = fetchPost();
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
    // TODO: implement build
    throw UnimplementedError();
  }
}
