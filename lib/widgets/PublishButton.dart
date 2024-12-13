import 'package:flutter/material.dart';

class PublishButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PublishButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      icon: Icon(Icons.publish, color: theme.colorScheme.onPrimary),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
      ),
      onPressed: onPressed,
    );
  }
}
