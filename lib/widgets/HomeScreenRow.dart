import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/AddEventButton.dart';

class HomeSearchRow extends StatelessWidget {
  const HomeSearchRow({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 175,
          height: 40,
          child: SearchBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
            hintText: "search",
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                print("tapped add friends");
              },
              child: Icon(Icons.add),
            ),
            AddEventButton()

          ],
        )
      ],
    );
  }
}
