import 'package:hedieaty/models/Event.dart';

class EventsService {
  Future<List<Event>> getUserEvents (String phone, String sortBy) async{
    await Future.delayed(const Duration(seconds: 2));
    Event e1 = Event(1, "birthday", DateTime.parse("2025-08-05"));
    Event e2 = Event(2, "birthday", DateTime.parse("2025-08-05"));
    Event e3 = Event(3, "birthday", DateTime.parse("2025-08-05"));
    return [e1, e2, e3];
  }
}
