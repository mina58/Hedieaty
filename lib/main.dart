import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/repositories/UserRepository.dart';
import 'package:hedieaty/screens/EventListScreen.dart';
import 'package:hedieaty/screens/EventScreen.dart';
import 'package:hedieaty/screens/FriendProfileScreen.dart';
import 'package:hedieaty/screens/GiftDetailsScreen.dart';
import 'package:hedieaty/screens/HomeScreen.dart';
import 'package:hedieaty/screens/LoginScreen.dart';
import 'package:hedieaty/screens/OwnerProfileScreen.dart';
import 'package:hedieaty/screens/PledgedGiftsScreen.dart';
import 'package:hedieaty/screens/SignupScreen.dart';
import 'package:hedieaty/services/EventsService.dart';
import 'package:hedieaty/services/FriendsService.dart';
import 'package:hedieaty/services/GiftsService.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => UserRepository(),
        ),
        Provider<OwnerUserService>(
          create: (_) => OwnerUserService(),
        ),
        ProxyProvider2<OwnerUserService, UserRepository, FriendsService>(
            update: (create, ownerUserService, userRepository, previous) {
          return FriendsService(ownerUserService.getOwner(), userRepository);
        }),
        Provider<EventsService>(
          create: (_) => EventsService(),
        ),
        Provider<GiftsService>(
          create: (_) => GiftsService(),
        ),
        Provider<ThemeData>(
          create: (_) => ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
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
      routes: {
        '/event_list': (context) => EventListScreen(),
        '/event': (context) => EventScreen(),
        "/gift_details": (context) => GiftDetailsScreen(),
        "/owner_profile": (context) => OwnerProfileScreen(),
        "/friend_profile": (context) => FriendProfileScreen(),
        "/pledged_gifts": (context) => PledgedGiftsScreen(),
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignupScreen(),
      },
      home: AuthWrapper(), // Use AuthWrapper to decide the initial screen
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loading indicator while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // If the user is logged in, show HomeScreen
        if (snapshot.hasData) {
          return HomeScreen();
        }

        // Otherwise, show the LoginScreen
        return LoginScreen();
      },
    );
  }
}
