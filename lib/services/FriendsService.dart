import '../models/User.dart';

class FriendsService {
  final List<User> _allFriends = [];

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
        "https://avatar.iran.liara.run/public",
        _allFriends.length,
      ),
    );
  }

  Future<List<User>> searchFriends(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) {
      return List<User>.from(_allFriends);
    }
    return _allFriends.where((friend) =>
        friend.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
}

