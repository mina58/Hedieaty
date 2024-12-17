import 'package:hedieaty/database/DatabaseHelper.dart';
import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/repositories/FirebaseEventRepository.dart';
import 'package:hedieaty/repositories/LocalDBEventRepository.dart';

import '../models/Gift.dart';

class LocalDBGiftRepository {
  LocalDBGiftRepository(
    this._localDBEventRepository,
  );

  final LocalDBEventRepository _localDBEventRepository;

  Future<List<Gift>> getGiftsByEvent(Event event) async {
    final db = await DatabaseHelper.instance.database;
    try {
      // Query the gifts table where the event_id matches the event's id
      final List<Map<String, dynamic>> giftMaps = await db.query(
        'gifts',
        where: 'event_id = ?',
        whereArgs: [event.id],
      );

      // Convert the query results into a list of Gift objects
      List<Gift> gifts = giftMaps.map((giftMap) {
        return Gift(
          giftMap['id'].toString(),
          giftMap['name'] as String,
          giftMap['price'] as int,
          giftMap['description'] as String,
          event,
          false,
          null,
          giftMap['category'] as String,
          "https://hedieaty.s3.us-east-1.amazonaws.com/download.jpg"
        );
      }).toList();

      return gifts;
    } catch (e) {
      // Handle any errors that occur during the query
      throw Exception("Failed to retrieve gifts for event ${event.id}: $e");
    }
  }

  Future<void> addGiftToEvent(Gift gift) async {
    final db = await DatabaseHelper.instance.database;
    try {
      // Insert a new gift into the 'gifts' table
      await db.insert('gifts', {
        'name': gift.name,
        'price': gift.price,
        'description': gift.description,
        'category': gift.category,
        'image_url': gift.imageURL,
        'event_id': gift.event.id,
      });
    } catch (e) {
      throw Exception("Failed to add gift to event ${gift.event.id}: $e");
    }
  }

  Future<void> updateGift(Gift gift) async {
    final db = await DatabaseHelper.instance.database;
    try {
      await db.update(
        'gifts',
        {
          'name': gift.name,
          'price': gift.price,
          'description': gift.description,
          'category': gift.category,
          'image_url': gift.imageURL,
          'event_id': gift.event.id,
        },
        where: 'id = ?',
        whereArgs: [gift.id],
      );
    } catch (e) {
      throw Exception("Failed to update gift with ID ${gift.id}: $e");
    }
  }

}
