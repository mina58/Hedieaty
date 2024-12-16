import 'package:hedieaty/models/Event.dart';

import '../models/User.dart';

class EventScreenArguments {
  EventScreenArguments(this.event, this.isOwnerEvent, this.user);

  final Event event;
  final bool isOwnerEvent;
  final User user;
}
