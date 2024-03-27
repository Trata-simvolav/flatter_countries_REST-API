import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const SecondPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 70.0, top: 35.0, left: 20.0),
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 45),
            buildCountriesText(
                "Native Name",
                firstValueGeter(
                    item['name']['nativeName'].values.first, 'common')),
            const SizedBox(height: 15),
            buildCountriesText("Population", "${item['population']}"),
            const SizedBox(height: 15),
            buildCountriesText("Region", "${item['region']}"),
            const SizedBox(height: 15),
            buildCountriesText("Sub Region", "${item['subregion']}"),
            const SizedBox(height: 15),
            buildCountriesText("Capital", "${item['capital'][0]}"),
            const SizedBox(height: 40),
            buildCountriesText("Top Level Domain", "${item['tld'][0]}"),
            const SizedBox(height: 15),
            buildCountriesText("Currencies",
                firstValueGeter(item['currencies'].values.first, 'name')),
            const SizedBox(height: 15), //borders
            buildCountriesText("Languages: ", languagesRet(item['languages'])),
            const SizedBox(height: 30),
            // const Text(
            //   "Borders",
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildCountriesText(String primaryValue, String secondaryValue) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$primaryValue: ",
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: secondaryValue,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
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
}
