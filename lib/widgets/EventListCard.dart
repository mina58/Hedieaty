import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventScreenArguments.dart';

import '../models/Event.dart';
import 'EditButton.dart';
import 'MyCard.dart';

class EventListCard extends StatelessWidget {
  const EventListCard({
    super.key,
    required this.isOwnerEventCard,
    required this.event,
    required this.username,
  });

  final bool isOwnerEventCard;
  final Event event;
  final String username;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MyCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.name,
                style:
                    TextStyle(fontSize: theme.textTheme.titleLarge!.fontSize),
              ),
              Text(
                  "${event.date.day.toString()}/${event.date.month.toString()}/${event.date.year.toString()}"),
            ],
          ),
          ...(isOwnerEventCard
              ? [
                  EditButton(
                    onPressed: () {},
                  )
                ]
              : [])
        ],
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          "/event",
          arguments: EventScreenArguments(event, isOwnerEventCard, username),
        );
      },
    );
  }
}
