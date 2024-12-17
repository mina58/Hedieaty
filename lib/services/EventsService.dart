import 'dart:math';
import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/repositories/FirebaseEventRepository.dart';
import 'package:hedieaty/repositories/FirebaseGiftRepository.dart';
import 'package:hedieaty/repositories/LocalDBEventRepository.dart';
import 'package:hedieaty/repositories/LocalDBGiftRepository.dart';
import 'package:hedieaty/services/OwnerUserService.dart';

class EventsService {
  EventsService(
    this._ownerUserService,
    this._localDBEventRepository,
    this._firebaseEventRepository,
    this._localDBGiftRepository,
    this._firebaseGiftRepository,
  );

  final OwnerUserService _ownerUserService;
  final LocalDBEventRepository _localDBEventRepository;
  final FirebaseEventRepository _firebaseEventRepository;
  final LocalDBGiftRepository _localDBGiftRepository;
  final FirebaseGiftRepository _firebaseGiftRepository;

  Future<Event> addEvent(String name, DateTime date) async {
    final owner = await _ownerUserService.getOwner();
    return await _localDBEventRepository
        .addEventForUser(Event("0", name, date, false, owner));
  }

  Future<List<Event>> getUserEvents(String id, String sortBy) async {
    final owner = await _ownerUserService.getOwner();

    // Fetch events from Firebase
    final firebaseEvents = await _firebaseEventRepository.getEventsByUserId(id);

    // Fetch events from local database if the user is the owner
    List<Event> localEvents = [];
    if (owner.id == id) {
      localEvents = await _localDBEventRepository.getEventsByUserId(owner.id);
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

  Future<Event> editEvent(String eventId, String name, DateTime date) async {
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
    return await _localDBEventRepository.updateEvent(updatedEvent);
  }

  Future<Event> publishEvent(String eventId) async {
    final localEvent = await _localDBEventRepository.getEventById(eventId);
    final gifts = await _localDBGiftRepository.getGiftsByEvent(localEvent!);
    final newEvent = await _firebaseEventRepository.addEvent(localEvent);
    for (var gift in gifts) {
      await _firebaseGiftRepository
          .addGiftToEvent(gift.copyWith(event: newEvent));
    }
    await _localDBEventRepository.deleteEvent(localEvent!);
    return newEvent;
  }
}
