import 'package:flutter/material.dart';
import 'package:hedieaty/screens/ProfileScreen.dart';

import 'MyCard.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: CircleAvatar(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/profile", arguments: false);
                  },
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Doe",
                style: TextStyle(
                  fontSize: theme.textTheme.titleLarge!.fontSize,
                ),
              ),
              Text(
                "upcoming events: 1",
                style: TextStyle(fontSize: theme.textTheme.bodySmall!.fontSize),
              ),
            ],
          )
        ],
      ),
      theme: theme,
      onTap: () {
        Navigator.pushNamed(
          context,
          "/event_list",
          arguments: false,
        );
      },
    );
  }
}
