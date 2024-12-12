import 'package:hedieaty/models/Event.dart';

class EventScreenArguments {
  EventScreenArguments(this.event, this.isOwnerEvent, this.username);

  final Event event;
  final bool isOwnerEvent;
  final String username;
}
