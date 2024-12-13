import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventListScreenArguments.dart';
import 'package:hedieaty/services/EventsService.dart';
import 'package:hedieaty/widgets/AsyncListView.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/SortByOption.dart';
import 'package:provider/provider.dart';

import '../models/Event.dart';
import '../widgets/AddEventButton.dart';
import '../widgets/EventListCard.dart';
import '../widgets/SortOptions.dart';

class EventListScreen extends StatefulWidget {
  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  String _sortBy = "name";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final EventsService eventsService = Provider.of<EventsService>(context);
    final EventListScreenArguments arguments =
    ModalRoute.of(context)!.settings.arguments as EventListScreenArguments;
    final bool isOwnerEventList = arguments.isOwnerEventList;
    final String username = arguments.username;
    final String userPhone = arguments.userPhone;
    final Future<List<Event>> userEvents =
    eventsService.getUserEvents(userPhone, _sortBy);

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
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
                    "${username}'s Events",
                    style: TextStyle(
                        fontSize: theme.textTheme.titleLarge!.fontSize),
                  ),
                  AddEventButton(),
                ],
              ),
            ),
            SortOptions(
              options: [
                SortByOption(
                    text: "name",
                    onTap: () {
                      setState(() {
                        _sortBy = "name";
                      });
                    }),
                SortByOption(
                    text: "date",
                    onTap: () {
                      setState(() {
                        _sortBy = "date";
                      });
                    }),
                SortByOption(
                    text: "status",
                    onTap: () {
                      setState(() {
                        _sortBy = "status";
                      });
                    }),
              ],
            ),
            Expanded(
              child: AsyncListView(
                future: userEvents,
                builder: (event) => EventListCard(
                  isOwnerEventCard: isOwnerEventList,
                  event: event,
                  username: username,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
