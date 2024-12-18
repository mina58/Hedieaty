import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hedieaty/services/NotificationsService.dart';

class NotificationBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationsService = Provider.of<NotificationsService>(context, listen: false);

    return StreamBuilder<int>(
      stream: notificationsService.notificationCountStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == 0) {
          return SizedBox(); // Hide badge if no notifications
        }
        return CircleAvatar(
          radius: 12,
          backgroundColor: Colors.red,
          child: Text(
            snapshot.data.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        );
      },
    );
  }
}