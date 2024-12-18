import 'package:flutter/material.dart';

import '../models/MyNotification.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.notification,
  });

  final MyNotification notification;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.title,
            style: theme.textTheme.titleMedium,
          ),
          Text(notification.body),
        ],
      ),
    );
  }
}