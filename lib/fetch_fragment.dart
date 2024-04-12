import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

// ignore: must_be_immutable
class FetchElement extends StatefulWidget {
  FetchElement({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FetchElementState createState() => _FetchElementState();

  // ignore: library_private_types_in_public_api
  _FetchElementState fetchElementState = _FetchElementState();
  List<dynamic> get futureData => fetchElementState.futureDataList;
}

class _FetchElementState extends State<FetchElement> {
  late List<dynamic> futureDataList;

  @override
  void initState() {
    super.initState();
  }

  void fetchPost() async {
    final response =
        await http.get(Uri.parse("https://restcountries.com/v3.1/all"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        futureDataList = data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
