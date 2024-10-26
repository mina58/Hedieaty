import 'package:flutter/material.dart';

import 'EditButton.dart';
import 'MyCard.dart';

class EventListCard extends StatelessWidget {
  const EventListCard({
    super.key,
    required this.theme,
    required this.isOwnerEventCard,
  });

  final ThemeData theme;
  final bool isOwnerEventCard;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        theme: theme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Birthday",
                  style:
                      TextStyle(fontSize: theme.textTheme.titleLarge!.fontSize),
                ),
                Text("5/8/2025"),
              ],
            ),
            ...(isOwnerEventCard
                ? [
                    EditButton(onPressed: () {},)
                  ]
                : [])
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/event",
            arguments: isOwnerEventCard,
          );
        });
  }
}


