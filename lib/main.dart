import 'package:flutter/material.dart';
import 'package:pizza_app_challenge/screens/home_screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza App Challenge',
      home: const HomeScreen(),
      // home: PizzaSelectionPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfff9f7f2),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xfff9f7f2)),
        fontFamily: "ITC",
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.brown),
          titleMedium: TextStyle(color: Colors.brown),
          titleSmall: TextStyle(color: Colors.brown),
        ),
      ),
    );
  }
}
