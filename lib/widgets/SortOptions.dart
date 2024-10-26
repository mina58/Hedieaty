import 'package:flutter/material.dart';

import 'SortByOption.dart';
import 'SortToggleButton.dart';

class SortOptions extends StatelessWidget {
  const SortOptions({
    super.key,
    required this.theme,
    required this.options,
  });

  final ThemeData theme;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Row(
        children: [
          SortToggleButton(theme: theme),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Wrap(
                runSpacing: 8,
                spacing: 8,
                children: options
                    .map((option) => SortByOption(theme: theme, text: option))
                    .toList()),
          ),
        ],
      ),
    );
  }
}