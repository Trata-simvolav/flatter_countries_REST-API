// 0.1.3

import 'package:flutter/material.dart';
import 'fetchFragment.dart';
import 'detailPage.dart';

class ThemeProvider extends InheritedWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  ThemeProvider({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return oldWidget.isDarkMode != isDarkMode;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkMode: false, // Установим светлую тему по умолчанию
      toggleTheme: (bool isDarkMode) {
        // Функция для переключения темы
        // Здесь вы можете добавить код для сохранения текущей темы (например, в SharedPreferences)
      },
      child: Builder(
        builder: (context) {
          final themeProvider = ThemeProvider.of(context)!;

          return MaterialApp(
            theme:
                themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: MyHomePage(),
            // routes: {
            //   '/detail': (context) => SecondPage(item: {},),
            // },
          );
        },
      ),
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context)!;

    return ThemeProvider(
      // ignore: avoid_types_as_parameter_names
      toggleTheme: (bool) {},
      isDarkMode: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
                themeProvider.toggleTheme(themeProvider.isDarkMode);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: fetchElementState.futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<dynamic> data = snapshot.data as List<dynamic>;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = data[index];
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
                        color: Theme.of(context).colorScheme.background,
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
    );
  }

  Color invertedColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
