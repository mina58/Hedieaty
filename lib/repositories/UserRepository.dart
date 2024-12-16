import '../models/User.dart';

class UserRepository {
  var allFriends = [
    User(
      "1",
      "Alice Johnson",
      "1234567890",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      1,
    ),
    User(
      "1",
      "Bob Smith",
      "2345678901",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      2,
    ),
    User(
      "1",
      "Charlie Brown",
      "3456789012",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      3,
    ),
    User(
      "1",
      "Diana Prince",
      "4567890123",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      4,
    ),
    User(
      "1",
      "Evan Wright",
      "5678901234",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      5,
    ),
  ];

  Future<List<User>> getUserFriends(String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return allFriends;
  }

  Future<User?> getUserByPhone(String phone) async{
    await Future.delayed(const Duration(milliseconds: 500));
    return User(
      "1",
      "Evan Wright",
      "5678901234",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      5,
    );
  }

  Future<void> addFriend(User owner, User friend) async{
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
