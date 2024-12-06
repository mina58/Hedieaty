import 'package:flutter/material.dart';

class PledgeButton extends StatelessWidget {
  const PledgeButton({
    super.key,
    required this.is_pledged,
    required this.onPressed,
  });

  final bool is_pledged;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Icon(Icons.card_giftcard),
      style: IconButton.styleFrom(
          backgroundColor: is_pledged
              ? theme.colorScheme.tertiary
              : theme.colorScheme.primary,
          foregroundColor: is_pledged
              ? theme.colorScheme.onTertiary
              : theme.colorScheme.onPrimary),
    );
  }
}
