import 'package:hedieaty/repositories/UserRepository.dart';

import '../database/DatabaseHelper.dart';
import '../models/Event.dart';
import '../models/User.dart';

class LocalDBEventRepository {
  LocalDBEventRepository(this._userRepository);

  final UserRepository _userRepository;

  Future<Event> addEventForUser(Event event) async {
    final db = await DatabaseHelper.instance.database;
    final eventId = await db.insert("events", {
      "name": event.name,
      "date": event.date.toIso8601String(),
      "owner_id": event.owner.id,
    });
    return event.copyWith(id: eventId);
  }

  Future<List<Event>> getEventsByUserId(String id) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'events',
      where: 'owner_id = ?',
      whereArgs: [id],
    );

    final events = <Event>[];

    // Fetch the user only once, to avoid multiple asynchronous calls
    final user = await _userRepository.getUserByIdFromFirebase(id);

    if (user == null) return [];

    for (final map in result) {
      events.add(
        Event(
          map["id"] as int,
          map["name"] as String,
          DateTime.parse(map["date"] as String),
          false,
          user,
        ),
      );
    }
    return events;
  }

  Future<Event?> getEventById(int id) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    final eventMap = result.first;

    final user = await _userRepository
        .getUserByIdFromFirebase(eventMap['owner_id'] as String);

    if (user == null) {
      return null; // Return null if the user is not found
    }

    // Create and return the Event object
    return Event(
      eventMap['id'] as int,
      eventMap['name'] as String,
      DateTime.parse(eventMap['date'] as String),
      false,
      user,
    );
  }

  Future<Event> updateEvent(Event event) async {
    final db = await DatabaseHelper.instance.database;

    final id = await db.update(
      'events',
      {
        "name": event.name,
        "date": event.date.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [event.id],
    );
    return await getEventById(id) ?? event;
  }
}
