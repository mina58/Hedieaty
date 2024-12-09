import 'dart:math';

import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/models/User.dart';

import '../models/Gift.dart';

class GiftsService {
  Future<List<Gift>> getEventGifts(int eventId, String sortBy) async {
    await Future.delayed(const Duration(seconds: 2));
    final Gift g1 = Gift(
      1,
      "PS5",
      800,
      "very good play station five",
      Event(1, "birthday", DateTime(5243)),
      true,
      User("John Doe", "01234", "https://avatar.iran.liara.run/public", 0),
      "gaming",
      "https://random.imagecdn.app/300/200",
    );
    final Gift g2 = Gift(
      1,
      "PS5",
      800,
      "very good play station five",
      Event(1, "birthday", DateTime(5243)),
      true,
      null,
      "gaming",
      "https://random.imagecdn.app/300/200",
    );
    final Gift g3 = Gift(
      1,
      "PS5",
      800,
      "very good play station five",
      Event(1, "birthday", DateTime(5243)),
      false,
      User("John Doe", "01234", "https://avatar.iran.liara.run/public", 0),
      "gaming",
      "https://random.imagecdn.app/300/200",
    );
    final Gift g4 = Gift(
      1,
      "PS5",
      800,
      "very good play station five",
      Event(1, "birthday", DateTime(5243)),
      false,
      null,
      "gaming",
      "https://random.imagecdn.app/300/200",
    );
    return [g1, g2, g3, g4];
  }

  Future<bool> pledgeGift(int giftId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [true, false][Random().nextInt(2)];
  }

  Future<List<Gift>> getOwnerPledgedGifts() async{
    return await getEventGifts(1, "sf");
  }
}
