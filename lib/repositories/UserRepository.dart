import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/database/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/User.dart';

class UserRepository {
  Future<bool> isUserSavedLocally(String userId) async {
    final db = await DatabaseHelper.instance.database;
    final result =
        await db.query("users", where: "id = ?", whereArgs: [userId]);
    return result.isNotEmpty;
  }

  Future<User?> getUserByIdFromFirebase(String userId) async {
    final firestore = FirebaseFirestore.instance;

    // Fetch the user document from Firestore
    final result = await firestore.collection("users").doc(userId).get();

    // If the user does not exist, return null
    if (!result.exists) return null;

    // Get the user data
    final user = result.data();

    // Ensure user data is valid and map to User model
    if (user == null) return null;

    // Fetch the events subcollection for the user
    final eventsResult = await firestore
        .collection("users")
        .doc(userId)
        .collection("events")
        .get();

    // Count the number of events for the user
    final upcomingEvents = eventsResult.docs.length;

    // Return the User object with relevant information
    return User(
      userId,
      user["username"] ?? "", // Fallback to empty string if username is missing
      user["phone"] ?? "", // Fallback to empty string if phone is missing
      "https://avatar.iran.liara.run/public/", // Default avatar URL
      upcomingEvents,
    );
  }

  Future<void> addUserLocally(User user) async {
    final db = await DatabaseHelper.instance.database;
    db.insert(
        "users",
        {
          "id": user.id,
          "name": user.name,
          "phone": user.phone,
          "imageURL": user.imageUrl,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUserFriends(String userId) async {
    final db = await DatabaseHelper.instance.database;

    // Step 1: Get the list of friend IDs from the local database
    final friendIdsResult = await db.rawQuery('''
      SELECT friend_id
      FROM friends
      WHERE user_id = ?
    ''', [userId]);

    // Step 2: Extract the friend_ids from the result
    List<String> friendIds =
        friendIdsResult.map((map) => map['friend_id'] as String).toList();

    // Step 3: Use Firebase to fetch the full User objects for each friend_id
    List<User> friends = [];
    for (String friendId in friendIds) {
      User? friend = await getUserByIdFromFirebase(
          friendId); // Assuming this function is implemented
      if (friend != null) {
        friends.add(friend);
      }
    }

    return friends;
  }

  Future<User?> getUserByPhoneFromFirebase(String phone) async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Query the users collection to find the user by phone
      final result = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .limit(
              1) // We assume phone is unique, so we take only the first match
          .get();

      // Check if a user is found
      if (result.docs.isEmpty) {
        return null; // No user found
      }

      // Retrieve the user data
      final userData = result.docs.first.data();

      // Retrieve events count (or other logic for upcomingEvents)
      final eventsResult = await firestore
          .collection("users")
          .doc(result.docs.first.id)
          .collection("events")
          .get();
      final upcomingEvents = eventsResult.docs.length;

      // Return the User object
      return User(
        result.docs.first.id, // user ID
        userData["username"], // username
        phone, // phone
        userData["imageUrl"] ?? "https://avatar.iran.liara.run/public/",
        // default image
        upcomingEvents, // upcoming events
      );
    } catch (e) {
      print("Error fetching user by phone: $e");
      return null;
    }
  }

  Future<void> addFriendLocally(User owner, User friend) async {
    final db = await DatabaseHelper.instance.database;

    // Insert a new friendship into the friends table (owner -> friend)
    await db.insert("friends", {
      "user_id": owner.id,
      "friend_id": friend.id,
    });
  }
}
