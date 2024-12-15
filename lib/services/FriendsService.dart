import 'package:hedieaty/repositories/UserRepository.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';

class FriendsService {
  FriendsService(this._ownerFuture, this._userRepository);

  final Future<User> _ownerFuture;
  final UserRepository _userRepository;
  var _allFriends = [
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
    final owner = await _ownerFuture;
    return await _userRepository.getUserFriends(owner.phone);
  }

  Future<void> addFriend(String name, String phone) async {
    final owner = await _ownerFuture;
    final friend = await _userRepository.getUserByPhone(phone);

    if (friend == null) {
      throw Exception("User not found");
    }

    await _userRepository.addFriend(owner, friend);
  }

  Future<List<User>> searchFriends(String query) async {
    _allFriends = await getFriends();
    if (query.isEmpty) {
      return List<User>.from(_allFriends);
    }
    return _allFriends
        .where(
            (friend) => friend.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
