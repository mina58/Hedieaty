import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventListScreenArguments.dart';
import 'package:hedieaty/services/FriendsService.dart';
import 'package:provider/provider.dart';

import '../models/Friend.dart';
import '../widgets/AsyncListView.dart';
import '../widgets/HomeScreenCard.dart';
import '../widgets/HomeScreenRow.dart';
import '../widgets/MyAppBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FriendsService friendsService = Provider.of<FriendsService>(context);
    final Future<List<Friend>> friends = friendsService.getFriends();
    return Scaffold(
      appBar: MyAppBar(
        displayProfile: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: HomeSearchRow(),
          ),
          Expanded(
            child: AsyncListView(
              future: friends,
              builder: (friend) => HomeScreenCard(
                friend: friend,
                onAvatarTap: () {
                  Navigator.pushNamed(context, "/profile", arguments: false);
                },
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/event_list",
                    arguments: EventListScreenArguments(false, friend.name, friend.phone),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
