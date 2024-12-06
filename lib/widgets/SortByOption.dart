import 'package:flutter/material.dart';

class SortByOption extends StatelessWidget {
  const SortByOption({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Text(
            text,
            style: TextStyle(color: theme.colorScheme.onSecondary),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
