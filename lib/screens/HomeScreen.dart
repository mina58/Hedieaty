import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventListScreenArguments.dart';
import 'package:hedieaty/routingArguments/FriendProfileScreenArguments.dart';
import 'package:hedieaty/services/FriendsService.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../widgets/AsyncListView.dart';
import '../widgets/HomeScreenCard.dart';
import '../widgets/HomeSearchRow.dart';
import '../widgets/MyAppBar.dart';
import '../widgets/NotificationListener.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<User>> _friendsFuture;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  void _searchFriends(String query) {
    final FriendsService friendsService =
        Provider.of<FriendsService>(context, listen: false);
    setState(() {
      _friendsFuture = friendsService.searchFriends(query);
    });
  }

  void _loadFriends() {
    final FriendsService friendsService =
        Provider.of<FriendsService>(context, listen: false);
    _friendsFuture = friendsService.getFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        displayProfile: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: HomeSearchRow(
                  key: Key("home_search_row"),
                  controller: _searchController,
                  onSearchChanged: _searchFriends,
                  onAddFriend: () {
                    setState(() {
                      _loadFriends();
                    });
                  },
                ),
              ),
              Expanded(
                child: AsyncListView(
                  future: _friendsFuture,
                  builder: (friend) => HomeScreenCard(
                    friend: friend,
                    onAvatarTap: () {
                      Navigator.pushNamed(
                        context,
                        "/friend_profile",
                        arguments: FriendProfileScreenArguments(friend),
                      );
                    },
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/event_list",
                        arguments: EventListScreenArguments(
                          false,
                          friend,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          MyNotificationListener(),
        ],
      ),
    );
  }
}
