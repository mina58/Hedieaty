import 'package:flutter/material.dart';
import 'package:hedieaty/screens/EventListScreen.dart';
import 'package:hedieaty/screens/EventScreen.dart';
import 'package:hedieaty/screens/HomeScreen.dart';
import 'package:hedieaty/screens/ProfileScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.light),
          useMaterial3: true,
          textTheme: TextTheme()),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      title: 'Flutter Navigation Demo',
      initialRoute: '/',
      // The default route when the app starts
      routes: {
        '/': (context) => HomeScreen(),
        '/event_list': (context) => EventListScreen(),
        '/profile': (context) => ProfileScreen(),
        '/event': (context) => EventScreen(),
      },
    );
  }
}
