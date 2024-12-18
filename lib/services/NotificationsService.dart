import '../models/MyNotification.dart';

class NotificationsService {
  Future<List<MyNotification>> getNotifications() async {
    await Future.delayed(Duration(milliseconds: 100));
    return <MyNotification>[
      MyNotification("New Pledge", "peepeeepepee"),
      MyNotification("New Pledge", "peepeeepepee"),
      MyNotification("New Pledge", "peepeeepepee"),
      MyNotification("New Pledge", "peepeeepepee"),
      MyNotification("New Pledge", "peepeeepepee"),
      MyNotification("New Pledge", "peepeeepepee"),
      MyNotification("New Pledge", "peepeeepepee"),
      MyNotification("New Pledge", "peepeeepepee"),
    ];
  }

  Future<void> clearNotifications() async {
    await Future.delayed(Duration(milliseconds: 100));
  }
}
