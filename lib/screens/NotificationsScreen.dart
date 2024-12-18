import 'package:flutter/material.dart';
import 'package:hedieaty/services/NotificationsService.dart';
import 'package:hedieaty/widgets/AsyncListView.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:provider/provider.dart';

import '../models/MyNotification.dart';
import '../widgets/NotificationListener.dart';
import '../widgets/NotificationWidget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<List<MyNotification>> _notifications;

  @override
  void initState() {
    super.initState();
    // Initialize notifications future
    _loadNotifications();
  }

  void _loadNotifications() {
    final notificationsService =
    Provider.of<NotificationsService>(context, listen: false);
    _notifications = notificationsService.getNotifications();
  }

  Future<void> _clearNotifications() async {
    final notificationsService =
    Provider.of<NotificationsService>(context, listen: false);

    // Clear notifications
    await notificationsService.clearNotifications();

    // Reload notifications and update the UI
    setState(() {
      _loadNotifications();
    });

    // Optional: Show a confirmation Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All notifications cleared')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: MyAppBar(
        displayProfile: true,
        showNotificationsButton: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: _clearNotifications,
                  icon: Icon(Icons.delete, color: theme.colorScheme.onError,),
                  label: Text('Clear Notifications', style: TextStyle(color: theme.colorScheme.onError),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                  ),
                ),
              ),
              Expanded(
                child: AsyncListView(
                  future: _notifications,
                  builder: (notification) => NotificationWidget(
                    notification: notification,
                  ),
                ),
              ),
            ],
          ),
          MyNotificationListener(),
        ],
      ),
    );
  }
}
