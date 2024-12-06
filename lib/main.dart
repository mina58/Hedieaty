import 'package:flutter/material.dart';
import 'package:hedieaty/screens/EventListScreen.dart';
import 'package:hedieaty/screens/EventScreen.dart';
import 'package:hedieaty/screens/FriendProfileScreen.dart';
import 'package:hedieaty/screens/GiftDetailsScreen.dart';
import 'package:hedieaty/screens/HomeScreen.dart';
import 'package:hedieaty/screens/OwnerProfileScreen.dart';
import 'package:hedieaty/screens/PledgedGiftsScreen.dart';
import 'package:hedieaty/services/EventsService.dart';
import 'package:hedieaty/services/FriendsService.dart';
import 'package:hedieaty/services/GiftsService.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<FriendsService>(
          create: (_) => FriendsService(),
        ),
        Provider<EventsService>(
          create: (_) => EventsService(),
        ),
        Provider<GiftsService>(
          create: (_) => GiftsService(),
        ),
        Provider<OwnerUserService>(
          create: (_) => OwnerUserService(),
        ),
        Provider<ThemeData>(
          create: (_) => ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.dark),
            useMaterial3: true,
            textTheme: TextTheme(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeData>(context),
      darkTheme: Provider.of<ThemeData>(context),
      themeMode: ThemeMode.dark,
      title: 'Flutter Navigation Demo',
      initialRoute: '/',
      // The default route when the app starts
      routes: {
        '/': (context) => HomeScreen(),
        '/event_list': (context) => EventListScreen(),
        '/event': (context) => EventScreen(),
        "/gift_details": (context) => GiftDetailsScreen(),
        "/owner_profile": (context) => OwnerProfileScreen(),
        "/friend_profile": (context) => FriendProfileScreen(),
        "/pledged_gifts": (context) => PledgedGiftsScreen(),
      },
    );
  }
}
