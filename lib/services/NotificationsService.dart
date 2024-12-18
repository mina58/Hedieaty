import 'package:hedieaty/repositories/NotificationRepository.dart';
import 'package:hedieaty/services/OwnerUserService.dart';

import '../models/MyNotification.dart';

class NotificationsService {
  NotificationsService(this._ownerUserService, this._notificationRepository);

  final OwnerUserService _ownerUserService;
  final NotificationRepository _notificationRepository;

  Future<List<MyNotification>> getNotifications() async {
    final user = await _ownerUserService.getOwner();
    try {
      // Step 1: Retrieve notifications from Firebase
      List<MyNotification> firebaseNotifications =
          await _notificationRepository.getAllFromFirebase(user);

      // Step 2: Delete notifications from Firebase
      await _notificationRepository.deleteAllFromFirebase(user);

      // Step 3: Add the retrieved notifications to local storage
      for (var notification in firebaseNotifications) {
        // Assuming the repository handles adding to local storage
        await _notificationRepository.addToLocalDB(user, notification);
      }

      // Step 4: Retrieve all notifications from local storage and return
      List<MyNotification> localNotifications =
          await _notificationRepository.getAllFromLocalDB(user);
      localNotifications.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      return localNotifications;
    } catch (e) {
      // Handle errors (e.g., network issues, Firebase errors, etc.)
      print("Error in getNotifications: $e");
      return [];
    }
  }

  Future<void> clearNotifications() async {
    final user = await _ownerUserService.getOwner();
    await _notificationRepository.deleteAllFromLocalDB(user);
  }

  Stream<int> notificationCountStream() async* {
    final user = await _ownerUserService.getOwner();
    yield* _notificationRepository.notificationCountStream(user);
  }
}
