import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/NotificationsService.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: theme.colorScheme.onPrimary,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/notifications");
          },
        ),
        Positioned(
          right: 0,
          top: 0,
          child: StreamBuilder<int>(
            stream: Provider.of<NotificationsService>(context, listen: false)
                .notificationCountStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == 0) {
                return SizedBox(); // No badge if no notifications
              }
              return CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  snapshot.data.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
