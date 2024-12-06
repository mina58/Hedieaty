import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/PledgeButton.dart';

class GiftDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 200,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PS5",
                        style: TextStyle(
                            fontSize: theme.textTheme.titleLarge!.fontSize),
                      ),
                      Text(
                        "\$100",
                        style: TextStyle(
                            fontSize: theme.textTheme.titleLarge!.fontSize),
                      )
                    ],
                  ),
                ),
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("For John Doe's Birthday"),
              PledgeButton(is_pledged: false, onPressed: () {})],
            ),
          ],
        ),
      ),
    );
  }
}
