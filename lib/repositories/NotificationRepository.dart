import 'package:hedieaty/models/MyNotification.dart';

import '../models/User.dart';

class NotificationRepository {
  Future<List<MyNotification>> getAllFromFirebase(User user) async{
    await Future.delayed(Duration(milliseconds: 199));
    return [
      MyNotification("test", "test"),
      MyNotification("test", "test"),
      MyNotification("test", "test"),
      MyNotification("test", "test"),
    ];
  }

  Future<List<MyNotification>> getAllFromLocalDB(User user) async {
    await Future.delayed(Duration(milliseconds: 199));
    return [
      MyNotification("test", "test"),
      MyNotification("test", "test"),
      MyNotification("test", "test"),
      MyNotification("test", "test"),
    ];
  }

  Future<void> deleteAllFromFirebase(User user) async {
    await Future.delayed(Duration(milliseconds: 199));
  }

  Future<void> deleteAllFromLocalDB(User user) async {
    await Future.delayed(Duration(milliseconds: 199));
  }

  Future<void> addToLocalDB(User user, MyNotification notification) async{
    await Future.delayed(Duration(milliseconds: 199));
  }
}