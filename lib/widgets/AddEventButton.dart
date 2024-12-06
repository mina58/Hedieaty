import 'package:flutter/material.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.tertiary,
          foregroundColor: theme.colorScheme.onTertiary,
          elevation: 5),
      onPressed: () {
        print("tapped add event");
      },
      child: Icon(
        Icons.celebration,
        color: theme.colorScheme.onTertiary,
      ),
    );
  }
}
