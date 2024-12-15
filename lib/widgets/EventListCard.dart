import 'package:flutter/material.dart';
import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/routingArguments/EventScreenArguments.dart';
import 'package:hedieaty/services/EventsService.dart';
import 'package:hedieaty/widgets/MyCard.dart';
import 'package:provider/provider.dart';

import 'PublishButton.dart';

class EventListCard extends StatefulWidget {
  const EventListCard({
    Key? key,
    required this.isOwnerEventCard,
    required this.event,
    required this.username,
    required this.onPublish
  }) : super(key: key);

  final bool isOwnerEventCard;
  final Event event;
  final String username;
  final void Function() onPublish;

  @override
  State<EventListCard> createState() => _EventListCardState();
}

class _EventListCardState extends State<EventListCard> {
  bool _isPublishing = false;
  late bool _isPublished;

  @override
  void initState() {
    super.initState();
    _isPublished = widget.event.isPublished;
  }

  Future<void> _publishEvent() async {
    setState(() {
      _isPublishing = true;
    });
    try {
      final eventsService = Provider.of<EventsService>(context, listen: false);
      await eventsService.publishEvent(widget.event.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event published successfully')),
      );
      setState(() {
        _isPublishing = false;
        _isPublished = true;
      });
      widget.onPublish();
    } catch (e) {
      setState(() {
        _isPublishing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to publish event: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MyCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.name,
                style: theme.textTheme.titleLarge,
              ),
              Text(
                "${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year}",
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
          if (widget.isOwnerEventCard && !_isPublished)
            _isPublishing
                ? CircularProgressIndicator()
                : PublishButton(onPressed: _publishEvent)
          else if (widget.isOwnerEventCard && _isPublished)
            Icon(Icons.check_circle,
                color: Theme.of(context).colorScheme.primary)
        ],
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          "/event",
          arguments: EventScreenArguments(
            widget.event,
            widget.isOwnerEventCard,
            widget.username,
          ),
        );
      },
    );
  }
}
