import 'package:flutter/material.dart';

class SortByOption extends StatelessWidget {
  const SortByOption({
    super.key,
    required this.theme, required this.text,
  });

  final ThemeData theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Text(
          text,
          style: TextStyle(color: theme.colorScheme.onSecondary),
        ),
      ),
    );
  }
}
