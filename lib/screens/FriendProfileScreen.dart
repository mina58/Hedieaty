import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';

import '../widgets/EditButton.dart';

class FriendProfileScreen extends StatelessWidget {
  const FriendProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/profile_pic.jpeg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "John Doe",
                        style: theme.textTheme.headlineLarge,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      EditButton(onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/event_list",
                              arguments: true);
                        },
                        child: Text("Events"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.tertiary,
                          foregroundColor: theme.colorScheme.onTertiary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Pledged"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                          foregroundColor: theme.colorScheme.onSecondary,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
