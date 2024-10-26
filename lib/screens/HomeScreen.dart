import 'package:flutter/material.dart';

import '../widgets/HomeScreenCard.dart';
import '../widgets/HomeScreenRow.dart';
import '../widgets/MyAppBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: MyAppBar(
        theme: theme,
        displayProfile: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: HomeSearchRow(
              theme: theme,
            ),
          ),
          ...[1, 1, 1, 1, 1, 1, 1].map(
            (_) => Padding(
              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: HomeScreenCard(theme: theme),
            ),
          )
        ],
      ),
    );
  }
}
