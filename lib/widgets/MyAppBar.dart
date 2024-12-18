import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.displayProfile,
    this.showLogoutButton = true,
    this.showNotificationsButton = true,
  });

  final bool displayProfile;
  final bool showLogoutButton;
  final bool showNotificationsButton;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      leading: InkWell(
        child: Image.asset("assets/logo.png"),
        onTap: () {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.pushNamed(context, "/");
          } else {
            Navigator.pushNamed(context, "/login");
          }
        },
      ),
      titleTextStyle: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: theme.textTheme.titleLarge!.fontSize,
      ),
      title: const Text(
        "Hedieaty",
      ),
      actions: [
        if (showNotificationsButton)
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: theme.colorScheme.onPrimary,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/notifications");
            },
          ),
        if (displayProfile)
          InkWell(
            child: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/owner_profile", arguments: true);
            },
          ),
        if (showLogoutButton)
          IconButton(
            icon: Icon(
              Icons.logout,
              color: theme.colorScheme.onPrimary,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (_) => false);
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
