import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/repositories/UserRepository.dart';

import '../models/Event.dart';
import '../models/User.dart';

class FirebaseEventRepository {
  final UserRepository _userRepository;
  final _firestore = FirebaseFirestore.instance;

  FirebaseEventRepository(this._userRepository);

  Future<List<Event>> getEventsByUserId(String userId) async {
    try {
      CollectionReference eventsCollection =
          _firestore.collection('users').doc(userId).collection('events');

      QuerySnapshot querySnapshot = await eventsCollection.get();

      // List to store the event objects
      List<Event> events = [];

      // Loop through the documents in the query result
      for (var doc in querySnapshot.docs) {
        // Get the data for each event
        var data = doc.data() as Map<String, dynamic>;

        User? user = await _userRepository.getUserByIdFromFirebase(userId);

        Event event = Event(
          doc.id,
          data['name'],
          DateTime.parse(data['date']),
          true,
          user!,
        );

        // Add the event to the list
        events.add(event);
      }

      return events;
    } catch (e) {
      throw Exception("Failed to retrieve events for user $userId: $e");
    }
  }

  Future<Event> addEvent(Event event) async {
    try {
      String userId = event.owner.id;

      DocumentReference userDocRef = _firestore.collection('users').doc(userId);

      CollectionReference eventsCollection = userDocRef.collection('events');

      DocumentReference eventRef = await eventsCollection.add({
        'name': event.name,
        'date': event.date.toIso8601String(),
      });

      return event.copyWith(id: eventRef.id, isPublished: true);
    } catch (e) {
      throw Exception("Failed to add event: $e");
    }
  }
}
