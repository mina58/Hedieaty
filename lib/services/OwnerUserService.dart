import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:hedieaty/models/User.dart';
import 'package:image_picker/image_picker.dart';

class OwnerUserService {
  Future<User> getOwner() async {
    final authUser = firebase_auth.FirebaseAuth.instance.currentUser!;
    final storedUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(authUser.uid)
        .get();
    return User(
      storedUser["username"],
      storedUser["phone"],
      authUser.photoURL ?? "https://avatar.iran.liara.run/public/",
      0,
    );
  }

  // Update the username in Firestore and Firebase Auth
  Future<void> updateUserName(String newName) async {
    final authUser = firebase_auth.FirebaseAuth.instance.currentUser!;
    final uid = authUser.uid;

    try {
      // Update the username in Firestore
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "username": newName,
      });

      // Optionally, update the display name in Firebase Auth
      await authUser.updateDisplayName(newName);

      print("Username updated successfully.");
    } catch (e) {
      print("Error updating username: $e");
      throw Exception("Failed to update username.");
    }
  }

  // Update the profile picture in Firebase Auth and Firestore
  Future<void> updateProfilePicture(XFile pickedFile) async {
    await Future.delayed(Duration(milliseconds: 10));
  }
}
