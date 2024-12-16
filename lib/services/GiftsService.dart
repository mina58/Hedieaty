import 'dart:math';
import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/models/User.dart';
import 'package:hedieaty/repositories/FirebaseGiftRepository.dart';
import 'package:hedieaty/repositories/LocalDBGiftRepository.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import '../models/Gift.dart';

class GiftsService {
  GiftsService(this._ownerUserService, this._localDBGiftRepository,
      this._firebaseGiftRepository);

  final OwnerUserService _ownerUserService;
  final LocalDBGiftRepository _localDBGiftRepository;
  final FirebaseGiftRepository _firebaseGiftRepository;
  final List<Gift> _gifts = [
    Gift(
      1,
      "PS5",
      800,
      "Very good PlayStation 5",
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true,
          User("sdaf", "dfsa", "dfsa", 234)),
      true,
      User("John Doe", "01234", "https://avatar.iran.liara.run/public", 0),
      "Gaming",
      "https://random.imagecdn.app/300/200",
    ),
    Gift(
      2,
      "Laptop",
      1200,
      "High-performance laptop",
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true,
          User("sdaf", "dfsa", "dfsa", 234)),
      false,
      null,
      "Electronics",
      "https://random.imagecdn.app/300/200",
    ),
    Gift(
      3,
      "Smartphone",
      700,
      "Latest model smartphone",
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true,
          User("sdaf", "dfsa", "dfsa", 234)),
      true,
      User("Alice", "98765", "https://avatar.iran.liara.run/public", 1),
      "Electronics",
      "https://random.imagecdn.app/300/200",
    ),
    Gift(
      4,
      "Headphones",
      150,
      "Noise-canceling headphones",
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true,
          User("sdaf", "dfsa", "dfsa", 234)),
      false,
      null,
      "Audio",
      "https://random.imagecdn.app/300/200",
    ),
  ];

  Future<List<Gift>> getEventGifts(
      User eventOwner, Event event, String sortBy) async {
    if (event.isPublished) {
      return await _firebaseGiftRepository.getGiftsByUserAndEvent(
          eventOwner, event);
    } else {
      return await _localDBGiftRepository.getGiftsByEvent(event);
    }
  }

  Future<void> addGift({
    required Event event,
    required String name,
    required int price,
    required String description,
    required String category,
    required String imageUrl,
  }) async {
    _localDBGiftRepository.addGiftToEvent(
        Gift(
          0,
          name,
          price,
          description,
          event,
          true,
          null,
          category,
          imageUrl,
        ),
        event);
  }

  Future<bool> pledgeGift(Gift gift) async {
    final User owner = await _ownerUserService.getOwner();
    try {
      await _firebaseGiftRepository.pledgeGift(gift, owner);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Gift>> getOwnerPledgedGifts() async {
    User owner = await _ownerUserService.getOwner();
    return await _firebaseGiftRepository.getPledgedGiftsByUser(owner);
  }

  Future<void> updateGift({
    required int giftId,
    required String name,
    required int price,
    required String description,
    required String category,
    required Gift gift,
  }) async {
    final newGift = gift.copyWith(
      name: name,
      price: price,
      description: description,
      category: category,
    );
    if (gift.event.isPublished) {
      await _firebaseGiftRepository.updateGift(newGift);
    } else {
      await _localDBGiftRepository.updateGift(newGift);
    }
  }
}
