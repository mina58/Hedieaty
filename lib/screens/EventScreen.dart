import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventScreenArguments.dart';
import 'package:hedieaty/services/GiftsService.dart';
import 'package:hedieaty/widgets/AsyncListView.dart';
import 'package:hedieaty/widgets/EditButton.dart';
import 'package:hedieaty/widgets/GiftCard.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/SortOptions.dart';
import 'package:provider/provider.dart';

import '../models/Event.dart';
import '../models/Gift.dart';
import '../widgets/SortByOption.dart';

class EventScreen extends StatefulWidget {

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String _sortBy = "name";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EventScreenArguments arguments =
    ModalRoute.of(context)!.settings.arguments as EventScreenArguments;
    final GiftsService giftsService = Provider.of<GiftsService>(context);
    final bool isOwnerEvent = arguments.isOwnerEvent;
    final Event event = arguments.event;
    final Future<List<Gift>> gifts = giftsService.getEventGifts(event.id, _sortBy);

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            EventScreenHeader(theme: theme, isOwnerEvent: isOwnerEvent),
            SizedBox(
              height: 8,
            ),
            SortOptions(
              options: [
                SortByOption(text: "name", onTap: () {
                  setState(() {
                    _sortBy = "name";
                  });
                }),
                SortByOption(text: "date", onTap: () {
                  setState(() {
                    _sortBy = "date";
                  });
                }),
                SortByOption(text: "status", onTap: () {
                  setState(() {
                    _sortBy = "status";
                  });
                }),
              ],
            ),
            Expanded(
              child: AsyncListView(future: gifts, builder: (gift) {
                return GiftCard(isOwnerGiftCard: isOwnerEvent, gift: gift);
              })
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
