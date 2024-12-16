import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/models/User.dart';

import '../models/Gift.dart';

class FirebaseGiftRepository {
  // Dummy Gifts
  List<Gift> gifts = [
    Gift(
      1,
      'Smartwatch',
      199,
      'A stylish smartwatch with fitness tracking features.',
      Event("1", ' Party', DateTime(2024, 12, 25), true, User("1", "sdaf", "dfsa", "dfsa", 234)),
      true,
      null,
      'Electronics',
      'https://example.com/smartwatch.jpg',
    ),
    Gift(
      2,
      'Personalized Mug',
      15,
      'A mug with a custom message or photo.',
      Event("1", 'Birthday Party', DateTime(2024, 12, 25), true, User("1", "sdaf", "dfsa", "dfsa", 234)),
      true,
      null,  // No one pledged
      'Home',
      'https://example.com/mug.jpg',
    ),
    Gift(
      3,
      'Bluetooth Speaker',
      49,
      'Portable wireless Bluetooth speaker for music lovers.',
      Event("1", 'Party', DateTime(2024, 12, 25), true, User("1", "sdaf", "dfsa", "dfsa", 234)),
      true,
      null,
      'Electronics',
      'https://example.com/speaker.jpg',
    ),
    Gift(
      4,
      'Wedding Photo Frame',
      25,
      'A beautiful photo frame for wedding memories.',
      Event("1", 'Birthday Party', DateTime(2024, 12, 25), true, User("1", "sdaf", "dfsa", "dfsa", 234)),
      false,
      null,  // No one pledged
      'Home',
      'https://example.com/photo_frame.jpg',
    ),
    Gift(
      5,
      'Cooking Class Voucher',
      100,
      'A voucher for an online cooking class.',
      Event("1", 'Birthday Party', DateTime(2024, 12, 25), true, User("1", "sdaf", "dfsa", "dfsa", 234)),
      true,
      null,
      'Experience',
      'https://example.com/cooking_class.jpg',
    ),
  ];
  Future<List<Gift>> getGiftsByUserAndEvent(User eventOwner, Event event) async {
    await Future.delayed(Duration(milliseconds: 100));
    return gifts;
  }

  Future<void> pledgeGift(Gift gift, User pledger) async{
    await Future.delayed(Duration(milliseconds: 100));
  }

  Future<List<Gift>> getPledgedGiftsByUser(User owner) async{
    await Future.delayed(Duration(milliseconds: 100));
    return gifts;
  }

  Future<void> updateGift(Gift newGift) async{
    await Future.delayed(Duration(milliseconds: 100));
  }

}