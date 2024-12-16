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

  Future<List<Gift>> getEventGifts(
      User eventOwner, Event event, String sortBy) async {
    List<Gift> gifts;

    if (event.isPublished) {
      gifts = await _firebaseGiftRepository.getGiftsByUserAndEvent(
          eventOwner, event);
    } else {
      gifts = await _localDBGiftRepository.getGiftsByEvent(event);
    }

    // Sorting the list based on the sortBy parameter
    switch (sortBy) {
      case 'name':
        gifts.sort(
            (a, b) => a.name.compareTo(b.name)); // Sort alphabetically by name
        break;
      case 'date':
        // Sort by event date, assuming `event.date` is what you want
        gifts.sort((a, b) => a.event.date.compareTo(b.event.date));
        break;
      case 'status':
        // Sort by pledge status (isPledged: false -> true)
        gifts.sort((a, b) {
          return a.isPledged == b.isPledged
              ? 0
              : a.isPledged
                  ? 1 // Pledged items come after available ones
                  : -1; // Available items come first
        });
        break;
      default:
        // Default case: no sorting
        break;
    }

    return gifts;
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
