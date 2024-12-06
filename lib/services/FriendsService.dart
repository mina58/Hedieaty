import '../models/User.dart';

class FriendsService {
  Future<List<User>> getFriends() async {
    await Future.delayed(const Duration(seconds: 2));
    // getFriends Stub
    return [1, 1,1,1,1,1,1,1,1,1,1,1,1].map(
        (e) => User(
          "John Doe",
          "0123456789",
          "https://avatar.iran.liara.run/public",
          12
        )
    ).toList();
  }
}