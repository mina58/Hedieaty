import 'dart:math';
import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/repositories/FirebaseEventRepository.dart';
import 'package:hedieaty/repositories/LocalDBEventRepository.dart';
import 'package:hedieaty/services/OwnerUserService.dart';

class EventsService {
  EventsService(
    this._ownerUserService,
    this._localDBEventRepository,
    this._firebaseEventRepository,
  );

  final OwnerUserService _ownerUserService;
  final LocalDBEventRepository _localDBEventRepository;
  final FirebaseEventRepository _firebaseEventRepository;

  Future<Event> addEvent(String name, DateTime date) async {
    final owner = await _ownerUserService.getOwner();
    return await _localDBEventRepository.addEventForUser(
        owner, Event(0, name, date, false));
  }

  Future<List<Event>> getUserEvents(String phone, String sortBy) async {
    final owner = await _ownerUserService.getOwner();

    // Fetch events from Firebase
    final firebaseEvents =
        await _firebaseEventRepository.getEventsByPhone(phone);

    // Fetch events from local database if the user is the owner
    List<Event> localEvents = [];
    if (owner.phone == phone) {
      localEvents = await _localDBEventRepository.getEventsByPhone(phone);
    }

    // Combine both Firebase and local events
    final allEvents = firebaseEvents + localEvents;

    // Sort the events based on the sortBy parameter
    allEvents.sort((a, b) {
      switch (sortBy) {
        case "name":
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case "date": // Sort by date
        case "status": // Status is treated the same as date
          return a.date.compareTo(b.date);
        default:
          throw ArgumentError("Invalid sortBy parameter: $sortBy");
      }
    });

    return allEvents;
  }

  Future<void> editEvent(int eventId, String name, DateTime date) async {
    // Check if the event exists in the local database
    final localEvent = await _localDBEventRepository.getEventById(eventId);

    if (localEvent == null) {
      throw Exception("Event not found in the local database.");
    }

    // Update the local event with the new details
    final updatedEvent = localEvent.copyWith(
      name: name,
      date: date,
    );

    // Save the updated event back to the local database
    await _localDBEventRepository.updateEvent(updatedEvent);
  }

  Future<void> publishEvent(int eventId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
