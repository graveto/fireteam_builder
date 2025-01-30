import 'package:flutter/material.dart';

import 'data/fighters.dart';
import 'fighter_list.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Fighter List')),
        body: FighterListWidget(fighters: fighters), // Your widget here
      ),
    );
  }
}
