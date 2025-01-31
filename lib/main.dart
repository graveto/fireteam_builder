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
        scaffoldBackgroundColor: Colors.orange[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[100],
          foregroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Fireteams',
              style: TextStyle(
                color: Colors.green[900],
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
