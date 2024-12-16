import 'package:hedieaty/repositories/UserRepository.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';

class FriendsService {
  FriendsService(this._ownerUserService, this._userRepository);

  final OwnerUserService _ownerUserService;
  final UserRepository _userRepository;

  Future<List<User>> getFriends() async {
    final owner = await _ownerUserService.getOwner();
    return await _userRepository.getUserFriends(owner.id);
  }

  Future<void> addFriend(String name, String phone) async {
    final owner = await _ownerUserService.getOwner();
    if (await _userRepository.isUserSavedLocally(owner.id)) {
      _userRepository.addUserLocally(owner);
    }

    final friend = await _userRepository.getUserByPhoneFromFirebase(phone);

    if (friend == null) {
      throw Exception("User not found");
    }

    await _userRepository.addFriendLocally(owner, friend);
  }

  Future<List<User>> searchFriends(String query) async {
    List<User> allFriends = await getFriends();
    if (query.isEmpty) {
      return List<User>.from(allFriends);
    }
    return allFriends
        .where(
            (friend) => friend.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
