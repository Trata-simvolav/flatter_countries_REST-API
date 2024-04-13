import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> textList = ['Apple', 'Banana', 'Orange', 'Grape'];
  final String searchText = 'Banana'; // Искомый элемент

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bubble List'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textList.map((text) {
              return text == searchText
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox(); // Если элемент не найден, возвращаем пустой виджет
            }).toList(),
          ),
        ),
      ),
    );
  }
}
