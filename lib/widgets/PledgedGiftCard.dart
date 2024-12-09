import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/GiftDetailsScreenArguments.dart';

import '../models/Gift.dart';
import 'MyCard.dart';

class PledgedGiftCard extends StatelessWidget {
  const PledgedGiftCard({super.key, required this.gift});

  final Gift gift;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MyCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gift.name,
                style:
                    TextStyle(fontSize: theme.textTheme.titleLarge!.fontSize),
              ),
              Text(
                "\$${gift.price.toString()}",
                style:
                    TextStyle(fontSize: theme.textTheme.titleMedium!.fontSize),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gift.event.name,
                style:
                    TextStyle(fontSize: theme.textTheme.titleMedium!.fontSize),
              ),
              Text(
                "${gift.event.date.day.toString()}/${gift.event.date.month.toString()}/${gift.event.date.year.toString()}",
                style:
                    TextStyle(fontSize: theme.textTheme.titleMedium!.fontSize),
              ),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, "/gift_details", arguments: GiftDetailsScreenArguments(gift));
      },
    );
  }
}
