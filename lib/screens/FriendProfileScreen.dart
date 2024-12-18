import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventListScreenArguments.dart';
import 'package:hedieaty/routingArguments/FriendProfileScreenArguments.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';

import '../models/User.dart';
import '../widgets/EditButton.dart';
import '../widgets/NotificationListener.dart';

class FriendProfileScreen extends StatelessWidget {
  const FriendProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final FriendProfileScreenArguments arguments = ModalRoute.of(context)!
        .settings
        .arguments as FriendProfileScreenArguments;
    final User friend = arguments.friend;

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    child: Image.network(friend.imageUrl),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            friend.name,
                            style: theme.textTheme.headlineLarge,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/event_list",
                                arguments: EventListScreenArguments(
                                  false,
                                  friend,
                                ),
                              );
                            },
                            child: Text("Events"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.tertiary,
                              foregroundColor: theme.colorScheme.onTertiary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          MyNotificationListener(),
        ],
      ),
    );
  }
}
