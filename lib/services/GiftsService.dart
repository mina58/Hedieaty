import 'dart:math';

import 'package:hedieaty/models/User.dart';

import '../models/Gift.dart';

class GiftsService {
  Future<List<Gift>> getGifts(int eventId, String sortBy) async {
    await Future.delayed(const Duration(seconds: 2));
    final Gift g1 = Gift(
      1,
      "PS5",
      800,
      "very good play station five",
      "birthday",
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
      "birthday",
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
      "birthday",
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
      "birthday",
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
}
