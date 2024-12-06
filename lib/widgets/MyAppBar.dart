import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.displayProfile});

  final bool displayProfile;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      leading: InkWell(
        child: Image.asset("assets/logo.png"),
        onTap: () {
          Navigator.pushNamed(context, "/");
        },
      ),
      titleTextStyle: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: theme.textTheme.titleLarge!.fontSize,
      ),
      title: Text(
        "Hedieaty",
      ),
      actions: displayProfile
          ? [
              InkWell(
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/owner_profile",
                      arguments: true);
                },
              )
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
