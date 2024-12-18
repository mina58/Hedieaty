import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hedieaty/services/NotificationsService.dart';
import 'package:hedieaty/models/MyNotification.dart';

import 'NotificationBanner.dart';

class MyNotificationListener extends StatefulWidget {
  const MyNotificationListener({Key? key}) : super(key: key);

  @override
  _MyNotificationListenerState createState() => _MyNotificationListenerState();
}

class _MyNotificationListenerState extends State<MyNotificationListener> {
  final List<MyNotification> _notifications = [];

  void _showNotificationBanner(MyNotification notification) {
    setState(() {
      _notifications.add(notification);
    });
  }

  void _removeNotificationBanner(MyNotification notification) {
    setState(() {
      _notifications.remove(notification);
    });
  }

  @override
  void initState() {
    super.initState();

    final notificationsService =
    Provider.of<NotificationsService>(context, listen: false);

    notificationsService.notificationListener().listen((notification) {
      print(notification);
      print("aloo");
      _showNotificationBanner(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _notifications.map((notification) {
        return NotificationBanner(
          title: notification.title,
          message: notification.message,
          onDismissed: () => _removeNotificationBanner(notification),
        );
      }).toList(),
    );
  }
}
