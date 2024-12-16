import '../models/User.dart';

class EventListScreenArguments {
  EventListScreenArguments(this.isOwnerEventList, this.user);

  final bool isOwnerEventList;
  final User user;
}
