import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/models/User.dart';
import 'package:hedieaty/repositories/UserRepository.dart';

import '../models/Gift.dart';

class FirebaseGiftRepository {
  FirebaseGiftRepository(this._userRepository);

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRepository _userRepository;

  Future<List<Gift>> getGiftsByEvent(Event event) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(event.owner.id);
      DocumentReference eventDocRef =
          userDocRef.collection('events').doc(event.id);
      CollectionReference giftsCollection = eventDocRef.collection('gifts');

      QuerySnapshot snapshot = await giftsCollection.get();

      var gifts = <Gift>[];
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        gifts.add(Gift(
          doc.id,
          data['name'] as String,
          data['price'] as int,
          data['description'] as String,
          event,
          true,
          data['pledged_by'] != null
              ? await _userRepository
                  .getUserByIdFromFirebase(data['pledged_by'])
              : null,
          data['category'] as String,
          data['image_url'] as String,
        ));
      }

      return gifts;
    } catch (e) {
      throw Exception("Failed to retrieve gifts for event ${event.id}: $e");
    }
  }

  Future<void> pledgeGift(Gift gift, User pledger) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(pledger.id);
      DocumentReference eventDocRef = _firestore
          .collection('users')
          .doc(gift.event.owner.id)
          .collection('events')
          .doc(gift.event.id);
      DocumentReference giftDocRef =
          eventDocRef.collection('gifts').doc(gift.id);

      await giftDocRef.update({
        'pledged_by': pledger.id,
      });

      // Add the gift to the pledged_gifts subcollection under the user
      await userDocRef.collection('pledged_gifts').add({
        'gift_id': gift.id,
        'name': gift.name,
        'price': gift.price,
        'description': gift.description,
        'category': gift.category,
        'image_url': gift.imageURL,
        'event_id': gift.event.id,
        'event_owner_id': gift.event.owner.id,
      });
    } catch (e) {
      throw Exception("Failed to pledge gift with ID ${gift.id}: $e");
    }
  }

  Future<List<Gift>> getPledgedGiftsByUser(User user) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.id);
      CollectionReference pledgedGiftsCollection =
          userDocRef.collection('pledged_gifts');

      // Fetch all pledged gifts for the user
      QuerySnapshot snapshot = await pledgedGiftsCollection.get();

      var pledgedGifts = <Gift>[];

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        // Retrieve the event owner and event details from the pledged gift document
        User eventOwner = (await _userRepository
            .getUserByIdFromFirebase(data['event_owner_id']))!;

        final eventData = (await _firestore
                .collection("users")
                .doc(eventOwner.id)
                .collection("events")
                .doc(data["event_id"])
                .get())
            .data()!;

        Event event = Event(
            eventData["id"].toString(),
            eventData["name"] as String,
            DateTime.parse(eventData["date"]),
            true,
            eventOwner);

        pledgedGifts.add(Gift(
          data['gift_id'],
          data['name'] as String,
          data['price'] as int,
          data['description'] as String,
          event,
          true,
          user,
          data['category'] as String,
          data['image_url'] as String,
        ));
      }

      return pledgedGifts;
    } catch (e) {
      throw Exception(
          "Failed to retrieve pledged gifts for user ${user.id}: $e");
    }
  }

  Future<void> updateGift(Gift newGift) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(newGift.event.owner.id);
      DocumentReference eventDocRef =
          userDocRef.collection('events').doc(newGift.event.id);
      DocumentReference giftDocRef =
          eventDocRef.collection('gifts').doc(newGift.id);

      // Update the gift document
      await giftDocRef.update({
        'name': newGift.name,
        'price': newGift.price,
        'description': newGift.description,
        'category': newGift.category,
        'image_url': newGift.imageURL,
      });
    } catch (e) {
      throw Exception("Failed to update gift with ID ${newGift.id}: $e");
    }
  }

  Future<void> addGiftToEvent(Gift gift) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(gift.event.owner.id);
      DocumentReference eventDocRef =
          userDocRef.collection('events').doc(gift.event.id);
      CollectionReference giftsCollection = eventDocRef.collection('gifts');

      await giftsCollection.add({
        'name': gift.name,
        'price': gift.price,
        'description': gift.description,
        'category': gift.category,
        'image_url': gift.imageURL,
      });
    } catch (e) {
      throw Exception("Failed to add gift to event ${gift.event.id}: $e");
    }
  }
}
