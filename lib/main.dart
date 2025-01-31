import 'package:fireteam_builder/fireteam_list.dart';
import 'package:fireteam_builder/selected_fighters_widget.dart';
import 'package:flutter/material.dart';

import 'data/fighters.dart';
import 'fighter_list.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 150, 161, 148),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 54, 75, 68),
          foregroundColor: Color.fromARGB(255, 150, 161, 148),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Fireteams',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body:
            FireteamListWidget(), // Set SelectedFightersWidget as the initial screen
      ),
    );
  }
}
