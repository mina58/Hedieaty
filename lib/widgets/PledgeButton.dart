import 'package:flutter/material.dart';

class PledgeButton extends StatelessWidget {
  const PledgeButton({
    super.key,
    required this.isPledged,
    required this.onPressed,
  });

  final bool isPledged;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Icon(Icons.card_giftcard),
      style: IconButton.styleFrom(
          backgroundColor: isPledged
              ? theme.colorScheme.tertiary
              : theme.colorScheme.primary,
          foregroundColor: isPledged
              ? theme.colorScheme.onTertiary
              : theme.colorScheme.onPrimary),
    );
  }
}
