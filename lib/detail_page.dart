import 'package:flutter/material.dart';
// import 'main.dart';

// ignore: must_be_immutable
class SecondPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const SecondPage({super.key, required this.item});

  // MyApp myApp = new MyApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "WHERE MY SOCS",
          style: TextStyle(
              color: invertedColor(Theme.of(context).colorScheme.primary)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 70.0, top: 20.0, left: 20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.black),
                                SizedBox(width: 5),
                                Text(
                                  'Back',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.network('${item['flags']['png']}'),
                  ),
                  const SizedBox(height: 45),
                  Text(
                    "${item['name']['common']}",
                    style: TextStyle(
                        fontSize: 30,
                        color: invertedColor(
                            Theme.of(context).colorScheme.primary),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 45),
                  FutureBuilder(
                    future: Future.delayed(
                      const Duration(milliseconds: 250),
                      () {
                        return languagesRet(item['languages']);
                      },
                    ),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildCountriesText(
                                "Native Name",
                                firstValueGeter(
                                    item['name']['nativeName'].values.first,
                                    'common'),
                                context),
                            const SizedBox(height: 15),
                            buildCountriesText(
                                "Population", "${item['population']}", context),
                            const SizedBox(height: 15),
                            buildCountriesText(
                                "Region", "${item['region']}", context),
                            const SizedBox(height: 15),
                            buildCountriesText(
                                "Sub Region", "${item['subregion']}", context),
                            const SizedBox(height: 15),
                            buildCountriesText(
                                "Capital", "${item['capital'][0]}", context),
                            const SizedBox(height: 40),
                            buildCountriesText("Top Level Domain",
                                "${item['tld'][0]}", context),
                            const SizedBox(height: 15),
                            buildCountriesText(
                                "Currencies",
                                firstValueGeter(
                                    item['currencies'].values.first, 'name'),
                                context),
                            const SizedBox(height: 15),
                            buildCountriesText("Languages: ",
                                languagesRet(item['languages']), context),
                            const SizedBox(height: 30),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCountriesText(
      String primaryValue, String secondaryValue, context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$primaryValue: ",
            style: TextStyle(
              fontSize: 17,
              color: invertedColor(Theme.of(context).colorScheme.primary),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: secondaryValue,
            style: TextStyle(
              fontSize: 17,
              color: invertedColor(Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  String firstValueGeter(Map<Object, dynamic> element, String needElement) {
    return '${element[needElement]}';
  }

  String languagesRet(Map<Object, dynamic> element) {
    String doneStr = '';

    for (var key in element.keys) {
      String commonValue = element[key];
      doneStr += '$commonValue ';
    }

    return doneStr;
  }

  Color invertedColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
