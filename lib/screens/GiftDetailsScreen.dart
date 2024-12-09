import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/GiftDetailsScreenArguments.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';

import '../models/Gift.dart';

class GiftDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final GiftDetailsScreenArguments arguments = ModalRoute.of(context)!
        .settings
        .arguments as GiftDetailsScreenArguments;
    final Gift gift = arguments.gift;
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
                    Image.network(
                      gift.imageURL,
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
                        gift.name,
                        style: TextStyle(
                            fontSize: theme.textTheme.titleLarge!.fontSize),
                      ),
                      Text(
                        "\$${gift.price}",
                        style: TextStyle(
                            fontSize: theme.textTheme.titleLarge!.fontSize),
                      )
                    ],
                  ),
                ),
                Text(gift.description)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
