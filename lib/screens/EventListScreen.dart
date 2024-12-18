import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventListScreenArguments.dart';
import 'package:hedieaty/services/EventsService.dart';
import 'package:hedieaty/widgets/AsyncListView.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/NotificationListener.dart';
import 'package:hedieaty/widgets/SortByOption.dart';
import 'package:provider/provider.dart';

import '../models/Event.dart';
import '../models/User.dart';
import '../widgets/AddEventButton.dart';
import '../widgets/EventListCard.dart';
import '../widgets/SortOptions.dart';

class EventListScreen extends StatefulWidget {
  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  String _sortBy = "name";
  late Future<List<Event>> userEvents;
  late User user;
  late EventsService eventsService;
  late bool isOwnerEventList;

  void _onPublish() {
    setState(() {
      _loadEvents();
    });
  }

  void _loadEvents() {
    userEvents = eventsService.getUserEvents(user.id, _sortBy);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    eventsService = Provider.of<EventsService>(context);
    final EventListScreenArguments arguments =
        ModalRoute.of(context)!.settings.arguments as EventListScreenArguments;
    isOwnerEventList = arguments.isOwnerEventList;
    user = arguments.user;
    _loadEvents();

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${user.name}'s Events",
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
                      user: user,
                      onPublish: _onPublish,
                    ),
                  ),
                ),
              ],
            ),
          ),
          MyNotificationListener(),
        ],
      ),
    );
  }
}
