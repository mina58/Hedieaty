import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';

import '../widgets/AddEventButton.dart';
import '../widgets/EventListCard.dart';
import '../widgets/SortByOption.dart';
import '../widgets/SortOptions.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isOwnerEventList =
        ModalRoute.of(context)!.settings.arguments as bool;

    return Scaffold(
      appBar: MyAppBar(theme: theme, displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "John Doe's Events",
                    style: TextStyle(
                        fontSize: theme.textTheme.titleLarge!.fontSize),
                  ),
                  AddEventButton(theme: theme)
                ],
              ),
            ),
            SortOptions(
              theme: theme,
              options: ["name", "date", "status"],
            ),
            Expanded(
              child: ListView(
                children: [1, 1, 1, 1, 1, 1, 1, 1]
                    .map((_) => EventListCard(
                          theme: theme,
                          isOwnerEventCard: isOwnerEventList,
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}




