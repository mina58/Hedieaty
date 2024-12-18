import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/models/MyNotification.dart';
import 'package:hedieaty/models/User.dart';
import 'package:hedieaty/database/DatabaseHelper.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all notifications for a user from Firebase
  Future<List<MyNotification>> getAllFromFirebase(User user) async {
    try {
      CollectionReference userNotifications = _firestore
          .collection('users')
          .doc(user.id)
          .collection('notifications');

      QuerySnapshot querySnapshot = await userNotifications.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MyNotification(
          data['title'] as String,
          data['message'] as String,
          DateTime.parse(data['dateTime']),
        );
      }).toList();
    } catch (e) {
      print("Error fetching notifications from Firebase: $e");
      return [];
    }
  }

  // Fetch all notifications for a user from the local SQLite database
  Future<List<MyNotification>> getAllFromLocalDB(User user) async {
    try {
      final db = await DatabaseHelper.instance.database;

      final result = await db.query(
        'notifications',
        where: 'user_id = ?',
        whereArgs: [user.id],
      );

      return result.map((row) {
        return MyNotification(
          row['title'] as String,
          row['message'] as String,
          DateTime.parse(row['timestamp'] as String)
        );
      }).toList();
    } catch (e) {
      print("Error fetching notifications from local DB: $e");
      return [];
    }
  }

  // Delete all notifications for a user from Firebase
  Future<void> deleteAllFromFirebase(User user) async {
    try {
      CollectionReference userNotifications = _firestore
          .collection('users')
          .doc(user.id)
          .collection('notifications');

      final querySnapshot = await userNotifications.get();

      // Batch delete all notifications
      WriteBatch batch = _firestore.batch();
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      print("Error deleting notifications from Firebase: $e");
    }
  }

  // Delete all notifications for a user from the local SQLite database
  Future<void> deleteAllFromLocalDB(User user) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'notifications',
        where: 'user_id = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      print("Error deleting notifications from local DB: $e");
    }
  }

  // Add a single notification to the local SQLite database
  Future<void> addToLocalDB(User user, MyNotification notification) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert('notifications', {
        'user_id': user.id,
        'title': notification.title,
        'message': notification.message,
        'timestamp': notification.dateTime.toIso8601String(),
      });
    } catch (e) {
      print("Error adding notification to local DB: $e");
    }
  }

  // Add a single notification to Firebase
  Future<void> addToFirebase(User user, MyNotification notification) async {
    try {
      CollectionReference userNotifications = _firestore
          .collection('users')
          .doc(user.id)
          .collection('notifications');

      await userNotifications.add({
        'title': notification.title,
        'message': notification.message,
        'dateTime': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Error adding notification to Firebase: $e");
    }
  }

  Stream<int> notificationCountStream(User user) {
    final CollectionReference notificationsRef = _firestore
        .collection('users')
        .doc(user.id)
        .collection('notifications');

    return notificationsRef.snapshots().map((snapshot) => snapshot.docs.length);
  }

  Stream<MyNotification> listenForNewNotifications(User user) {
    final CollectionReference notificationsRef = _firestore
        .collection('users')
        .doc(user.id)
        .collection('notifications');

    return notificationsRef.snapshots().expand((snapshot) {
      final currentTime = DateTime.now();
      return snapshot.docChanges
          .where((change) => change.type == DocumentChangeType.added)
          .map((change) {
        final data = change.doc.data() as Map<String, dynamic>;
        final notificationTime = DateTime.parse(data['dateTime']);

        // Filter notifications within the last 5 seconds
        if (currentTime.difference(notificationTime).inSeconds <= 5) {
          return MyNotification(
            data['title'] as String,
            data['message'] as String,
            notificationTime,
          );
        }
        return null; // Skip notifications older than 5 seconds
      })
          .where((notification) => notification != null)
          .cast<MyNotification>(); // Ensure non-null notifications are returned
    });
  }

}
