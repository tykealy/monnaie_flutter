import 'package:flutter/material.dart';
import 'widgets/spent_card.dart';
import 'widgets/history_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monnaie',
      debugShowCheckedModeBanner: false, // Add this line
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFebdedc),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "tk's monnaie app"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFebdedc),
          title: Text(title),
        ),
        body: ListView(
          children: const <Widget>[
            SpentCard(),
            HistoryList(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFc7bab8),
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFebdedc),
            selectedIconTheme: const IconThemeData(color: Color(0xFFfdbf1e)),
            selectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.currency_bitcoin), label: "Overview"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle), label: "ADD"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ],
          ),
        ));
  }
}
