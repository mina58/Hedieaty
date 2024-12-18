import 'package:flutter/material.dart';

class NotificationBanner extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onDismissed;

  const NotificationBanner({
    Key? key,
    required this.title,
    required this.message,
    required this.onDismissed,
  }) : super(key: key);

  @override
  _NotificationBannerState createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<NotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );

    // Slide the banner down
    _controller.forward();

    // Auto-dismiss after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        _dismissBanner();
      }
    });
  }

  void _dismissBanner() {
    _controller.reverse().then((_) {
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SlideTransition(
      position: _slideAnimation,
      child: GestureDetector(
        onVerticalDragEnd: (_) => _dismissBanner(),
        child: Material(
          elevation: 4,
          color: theme.colorScheme.secondary,
          child: Container(
            height: 75,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.notifications, color: theme.colorScheme.onSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.message,
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: theme.colorScheme.onPrimary),
                  onPressed: _dismissBanner,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
