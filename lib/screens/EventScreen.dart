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
    final String username = arguments.username;
    Future<List<Gift>> _gifts =
        giftsService.getEventGifts(event.id, _sortBy);

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            EventScreenHeader(
              theme: theme,
              isOwnerEvent: isOwnerEvent,
              username: username,
              event: event,
            ),
            const SizedBox(height: 8),
            SortOptionsWidget(
              currentSortBy: _sortBy,
              onSortChange: (sortBy) {
                setState(() {
                  _sortBy = sortBy;
                  _gifts = giftsService.getEventGifts(event.id, _sortBy);
                });
              },
            ),
            Expanded(
              child: GiftsList(
                giftsFuture: _gifts,
                isOwnerEvent: isOwnerEvent,
              ),
            ),
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
    required this.username,
    required this.event,
  });

  final ThemeData theme;
  final bool isOwnerEvent;
  final String username;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EventDetails(
          theme: theme,
          eventName: event.name,
          username: username,
          eventDate: event.date,
        ),
        if (isOwnerEvent) EditButton(onPressed: () {})
      ],
    );
  }
}

class EventDetails extends StatelessWidget {
  const EventDetails({
    super.key,
    required this.theme,
    required this.eventName,
    required this.username,
    required this.eventDate,
  });

  final ThemeData theme;
  final String eventName;
  final String username;
  final DateTime eventDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventName,
          style: theme.textTheme.headlineLarge,
        ),
        Text(
          username,
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          "${eventDate.day}/${eventDate.month}/${eventDate.year}",
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class SortOptionsWidget extends StatelessWidget {
  const SortOptionsWidget({
    super.key,
    required this.currentSortBy,
    required this.onSortChange,
  });

  final String currentSortBy;
  final ValueChanged<String> onSortChange;

  @override
  Widget build(BuildContext context) {
    return SortOptions(
      options: [
        SortByOption(
          text: "name",
          onTap: () => onSortChange("name"),
        ),
        SortByOption(
          text: "date",
          onTap: () => onSortChange("date"),
        ),
        SortByOption(
          text: "status",
          onTap: () => onSortChange("status"),
        ),
      ],
    );
  }
}

class GiftsList extends StatelessWidget {
  const GiftsList({
    super.key,
    required this.giftsFuture,
    required this.isOwnerEvent,
  });

  final Future<List<Gift>> giftsFuture;
  final bool isOwnerEvent;

  @override
  Widget build(BuildContext context) {
    return AsyncListView(
      future: giftsFuture,
      builder: (gift) => GiftCard(
        isOwnerGiftCard: isOwnerEvent,
        gift: gift,
      ),
    );
  }
}
