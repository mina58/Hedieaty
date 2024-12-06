import 'package:flutter/material.dart';

import 'SortByOption.dart';
import 'SortToggleButton.dart';

class SortOptions extends StatelessWidget {
  const SortOptions({
    super.key,
    required this.options,
  });

  final List<SortByOption> options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Row(
        children: [
          SortToggleButton(),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Wrap(
              runSpacing: 8,
              spacing: 8,
              children: options,
            ),
          ),
        ],
      ),
    );
  }
}
