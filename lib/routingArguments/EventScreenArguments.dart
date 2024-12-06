import 'package:hedieaty/models/Event.dart';

class EventScreenArguments {
  EventScreenArguments(this.event, this.isOwnerEvent);

  final Event event;
  final bool isOwnerEvent;
}
