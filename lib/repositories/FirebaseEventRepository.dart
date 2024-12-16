import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/repositories/UserRepository.dart';

import '../models/Event.dart';
import '../models/User.dart';

class FirebaseEventRepository {
  final UserRepository _userRepository;
  final _firestore = FirebaseFirestore.instance;

  FirebaseEventRepository(this._userRepository);

  Future<List<Event>> getEventsById(String id) async {
    await Future.delayed(Duration(milliseconds: 100));
    return [
      Event("1", "firebase event", DateTime.parse("2001-01-01"), true,
          User("1", "sdaf", "dfsa", "dfsa", 234))
    ];
  }

  Future<Event> addEvent(Event event) async {
    try {
      // Get the user ID from the event object
      String userId = event.owner.id;

      // Reference to the user's document
      DocumentReference userDocRef = _firestore.collection('users').doc(userId);

      // Reference to the subcollection "events" under the user's document
      CollectionReference eventsCollection = userDocRef.collection('events');

      // Add the event data to Firestore under the user's events subcollection
      DocumentReference eventRef = await eventsCollection.add({
        'name': event.name,
        'date': event.date.toIso8601String(),
        'owner_id': event.owner.id,
      });

      // Return the event object with the Firestore document ID
      return event.copyWith(id: eventRef.id);
    } catch (e) {
      // Handle any errors that occur during the Firestore operation
      throw Exception("Failed to add event: $e");
    }
  }
}
