import '../models/User.dart';

class FriendsService {
  final List<User> _allFriends = [
    User(
      "Alice Johnson",
      "1234567890",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      1,
    ),
    User(
      "Bob Smith",
      "2345678901",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      2,
    ),
    User(
      "Charlie Brown",
      "3456789012",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      3,
    ),
    User(
      "Diana Prince",
      "4567890123",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      4,
    ),
    User(
      "Evan Wright",
      "5678901234",
      "https://avatar.iran.liara.run/public/default_avatar.png",
      5,
    ),
  ];

  Future<List<User>> getFriends() async {
    await Future.delayed(const Duration(seconds: 2));
    // Return a copy of the list
    return List<User>.from(_allFriends);
  }

  Future<void> addFriend(String name, String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _allFriends.add(
      User(
        name,
        phone,
        "https://avatar.iran.liara.run/public/default_avatar.png",
        _allFriends.length + 1,
      ),
    );
  }

  Future<List<User>> searchFriends(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) {
      return List<User>.from(_allFriends);
    }
    return _allFriends
        .where(
            (friend) => friend.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
