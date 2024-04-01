import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

// ignore: must_be_immutable
class FetchElement extends StatefulWidget{
  const FetchElement({super.key});
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _FetchElementState extends State<FetchElement>{
  late Future<List<dynamic>> _futureData;
  Future<List<dynamic>> get futureData => _futureData;

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
    // TODO: implement build
    throw UnimplementedError();
  }  
}