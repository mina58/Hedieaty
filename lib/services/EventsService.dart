import 'dart:math';
import 'package:hedieaty/models/Event.dart';

class EventsService {
  final List<Event> _events = [];

  Future<List<Event>> getUserEvents(String phone, String sortBy) async {
    await Future.delayed(const Duration(seconds: 2));
    Event e1 = Event(1, "birthday", DateTime.parse("2025-08-05"));
    Event e2 = Event(2, "birthday", DateTime.parse("2025-08-05"));
    Event e3 = Event(3, "birthday", DateTime.parse("2025-08-05"));
    return _events.isNotEmpty ? _events : [e1, e2, e3];
  }

  /// Randomly throws an exception 30% of the time to simulate a failure.
  Future<Event> addEvent(String name, DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final random = Random();
    if (random.nextDouble() < 0.3) {
      throw Exception("Failed to create event due to a server error.");
    }
    Event event = Event(_events.length + 1, name, date);
    _events.add(event);
    return event;
  }

  Future<void> editEvent(int eventId, String name, DateTime date) async{
    await Future.delayed(const Duration(milliseconds: 500));
    return;
  }
}
