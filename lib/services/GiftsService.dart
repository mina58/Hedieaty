import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/models/User.dart';
import 'package:hedieaty/repositories/FirebaseGiftRepository.dart';
import 'package:hedieaty/repositories/LocalDBGiftRepository.dart';
import 'package:hedieaty/repositories/NotificationRepository.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import '../models/Gift.dart';
import '../models/MyNotification.dart';

class GiftsService {
  GiftsService(
    this._ownerUserService,
    this._localDBGiftRepository,
    this._firebaseGiftRepository,
    this._notificationRepository,
  );

  final OwnerUserService _ownerUserService;
  final LocalDBGiftRepository _localDBGiftRepository;
  final FirebaseGiftRepository _firebaseGiftRepository;
  final NotificationRepository _notificationRepository;

  Future<List<Gift>> getEventGifts(Event event, String sortBy) async {
    List<Gift> gifts;

    User appOwner = await _ownerUserService.getOwner();

    if (event.isPublished) {
      gifts = await _firebaseGiftRepository.getGiftsByEvent(event);
      if (appOwner.id == event.owner.id) {
        gifts = gifts.map((gift) => gift.copyWith(canPledge: false)).toList();
      }
    } else {
      gifts = await _localDBGiftRepository.getGiftsByEvent(event);
    }

    // Sorting the list based on the sortBy parameter
    switch (sortBy) {
      case 'name':
        gifts.sort(
            (a, b) => a.name.compareTo(b.name)); // Sort alphabetically by name
        break;
      case 'category':
        // Sort by event date, assuming `event.date` is what you want
        gifts.sort((a, b) => a.category.compareTo(b.category));
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
    if (!event.isPublished) {
      _localDBGiftRepository.addGiftToEvent(Gift(
        "1",
        name,
        price,
        description,
        event,
        true,
        null,
        category,
        imageUrl,
      ));
    } else {
      _firebaseGiftRepository.addGiftToEvent(Gift(
          "0",
          name,
          price,
          description,
          event,
          false,
          null,
          category,
          "https://hedieaty.s3.us-east-1.amazonaws.com/download.jpg"));
    }
  }

  Future<bool> pledgeGift(Gift gift) async {
    final User owner = await _ownerUserService.getOwner();
    try {
      await _firebaseGiftRepository.pledgeGift(gift, owner);

      // Create a notification for the gift owner
      final MyNotification notification = MyNotification(
        "Gift Pledged",
        "${owner.name} has pledged your gift: ${gift.name}",
        DateTime.now(),
      );

      // Send the notification to the gift owner
      await _notificationRepository.addToFirebase(
          gift.event.owner, notification);

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
    required String giftId,
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

  Stream<Gift> streamGift(Gift gift) {
    return _firebaseGiftRepository.streamGift(gift);
  }
}
