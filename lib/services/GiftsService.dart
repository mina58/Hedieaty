import 'dart:math';

import 'package:hedieaty/models/Friend.dart';

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
        Friend("John Doe", "01234", "https://avatar.iran.liara.run/public", 0),
        "gaming");
    final Gift g2 = Gift(
      1,
      "PS5",
      800,
      "very good play station five",
      "birthday",
      true,
      null,
      "gaming",);
    final Gift g3 = Gift(
        1,
        "PS5",
        800,
        "very good play station five",
        "birthday",
        false,
        Friend("John Doe", "01234", "https://avatar.iran.liara.run/public", 0),
        "gaming");
    final Gift g4 = Gift(
        1,
        "PS5",
        800,
        "very good play station five",
        "birthday",
        false,
        null,
        "gaming");
    return [g1, g2, g3, g4];
  }

  Future<bool> pledgeGift(int giftId) async{
    await Future.delayed(const Duration(seconds: 1));
    return [true, false][Random().nextInt(2)];
  }
}
