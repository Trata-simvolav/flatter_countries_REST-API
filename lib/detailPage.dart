import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final Map<String, dynamic> item;

  SecondPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
            Image.network('${item['flags']['png']}'),
            Text("${item['name']['common']}"),
            Text(""),
            Text(""),
            Text(""),
            Text(""),
            Text(""),
          ],
        ),
      ),
    );
  }
}
