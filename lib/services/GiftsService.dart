import 'dart:math';
import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/models/User.dart';
import '../models/Gift.dart';

class GiftsService {
  final List<Gift> _gifts = [
    Gift(
      1,
      "PS5",
      800,
      "Very good PlayStation 5",
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true),
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
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true),
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
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true),
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
      Event(1, "Birthday Party", DateTime(2025, 8, 5), true),
      false,
      null,
      "Audio",
      "https://random.imagecdn.app/300/200",
    ),
  ];

  Future<List<Gift>> getEventGifts(int eventId, String sortBy) async {
    await Future.delayed(const Duration(seconds: 2));
    return _gifts;
  }

  Future<void> addGift({
    required int eventId,
    required String name,
    required int price,
    required String description,
    required String category,
    required String imageUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _gifts.add(
      Gift(
        _gifts.length + 1,
        name,
        price,
        description,
        Event(eventId, "Event $eventId", DateTime.now(), false),
        false,
        null,
        category,
        imageUrl,
      ),
    );
  }

  Future<bool> pledgeGift(int giftId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [true, false][Random().nextInt(2)];
  }

  Future<List<Gift>> getOwnerPledgedGifts() async {
    return _gifts.where((gift) => gift.isPledged).toList();
  }

  Future<void> updateGift({
    required int giftId,
    required String name,
    required int price,
    required String description,
    required String category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _gifts.indexWhere((gift) => gift.id == giftId);
    if (index != -1) {
      _gifts[index] = _gifts[index].copyWith(
        name: name,
        price: price,
        description: description,
        category: category,
      );
    }
  }
}
