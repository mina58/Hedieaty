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
      authUser.uid,
      storedUser["username"],
      storedUser["phone"],
      authUser.photoURL ?? "https://avatar.iran.liara.run/public/",
      0,
    );
  }

  Future<void> updateUserName(String newName) async {
    final authUser = firebase_auth.FirebaseAuth.instance.currentUser!;
    final uid = authUser.uid;

    try {
      // Update the username in Firestore
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "username": newName,
      });

      await authUser.updateDisplayName(newName);

      print("Username updated successfully.");
    } catch (e) {
      print("Error updating username: $e");
      throw Exception("Failed to update username.");
    }
  }

  Future<void> updateProfilePicture(XFile pickedFile) async {
    await Future.delayed(Duration(milliseconds: 10));
  }
}
