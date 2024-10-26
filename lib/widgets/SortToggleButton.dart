import 'package:flutter/material.dart';

class SortToggleButton extends StatelessWidget {
  const SortToggleButton({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          print("toggle sort");
        },
        icon: Icon(Icons.sort_outlined),
        color: theme.colorScheme.onPrimary,
      ),
    );
  }
}
