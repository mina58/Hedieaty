import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/EditButton.dart';
import 'package:hedieaty/widgets/GiftCard.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/SortOptions.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isOwnerEvent =
        ModalRoute.of(context)!.settings.arguments as bool;

    return Scaffold(
      appBar: MyAppBar(theme: theme, displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            EventScreenHeader(theme: theme, isOwnerEvent: isOwnerEvent),
            SizedBox(
              height: 8,
            ),
            SortOptions(
              theme: theme,
              options: ["name", "category", "status"],
            ),
            Expanded(
              child: ListView(
                children: ([1, 1, 1, 1, 1, 1].map((_) => GiftCard(
                      isOwnerGiftCard: isOwnerEvent,
                      theme: theme,
                      isPledged: true,
                    ))).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventScreenHeader extends StatelessWidget {
  const EventScreenHeader({
    super.key,
    required this.theme,
    required this.isOwnerEvent,
  });

  final ThemeData theme;
  final bool isOwnerEvent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Birthday",
              style: theme.textTheme.headlineLarge,
            ),
            Text(
              "John Doe",
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              "5/8/2025",
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
        ...(isOwnerEvent ? [EditButton(onPressed: () {})] : [])
      ],
    );
  }
}
