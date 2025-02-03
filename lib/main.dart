import 'package:flutter/material.dart';
import 'package:fireteam_builder/screens/team_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Builder',
      theme: ThemeData(
        primaryColor: Color(0xFF003819), // Dark green
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green, // Base color for the theme
          accentColor: Color(0xFFCBB576), // Goldish yellow
        ),
        scaffoldBackgroundColor: Color(0xFF0B1A0C),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0B1A0C), // Dark green for app bar
          foregroundColor: Colors.white, // White text color for app bar
        ), // Very dark green
        // Add more theme properties as needed
      ),
      home: TeamListScreen(),
    );
  }
}