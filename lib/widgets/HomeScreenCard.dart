import 'package:flutter/material.dart';
import 'package:hedieaty/models/Friend.dart';

import 'MyCard.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    required this.friend,
    required this.onAvatarTap,
    required this.onTap,
  });

  final Friend friend;
  final void Function() onAvatarTap;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MyCard(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: CircleAvatar(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      child: Image.network(friend.imageUrl)),
                  onTap: onAvatarTap,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend.name,
                style: TextStyle(
                  fontSize: theme.textTheme.titleLarge!.fontSize,
                ),
              ),
              Text(
                "upcoming events: ${friend.upcomingEvents.toString()}",
                style: TextStyle(fontSize: theme.textTheme.bodySmall!.fontSize),
              ),
            ],
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
