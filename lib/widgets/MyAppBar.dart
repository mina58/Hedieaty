import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {super.key, required this.theme, required this.displayProfile});

  final ThemeData theme;
  final bool displayProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      leading: Image.asset("assets/logo.png"),
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
                  Navigator.pushNamed(context, "/profile", arguments: true);
                },
              )
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
