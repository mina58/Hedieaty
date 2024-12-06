import 'package:flutter/material.dart';

class SortToggleButton extends StatelessWidget {
  const SortToggleButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
