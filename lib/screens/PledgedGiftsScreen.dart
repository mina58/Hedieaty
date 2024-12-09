import 'package:flutter/material.dart';
import 'package:hedieaty/services/GiftsService.dart';
import 'package:hedieaty/widgets/AsyncListView.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/MyCard.dart';
import 'package:provider/provider.dart';

import '../models/Gift.dart';

class PledgedGiftsScreen extends StatelessWidget {
  const PledgedGiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GiftsService giftsService = Provider.of<GiftsService>(context);
    Future<List<Gift>> pledgedGifts = giftsService.getOwnerPledgedGifts();
    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AsyncListView(
            future: pledgedGifts,
            builder: (pledgedGift) {
              return MyCard(
                  child: PledgedGiftCard(gift: pledgedGift), onTap: () {});
            }),
      ),
    );
  }
}

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
                  style: TextStyle(
                      fontSize: theme.textTheme.titleMedium!.fontSize),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gift.event.name,
                  style: TextStyle(
                      fontSize: theme.textTheme.titleMedium!.fontSize),
                ),
                Text(
                  "${gift.event.date.day.toString()}/${gift.event.date.month.toString()}/${gift.event.date.year.toString()}",
                  style: TextStyle(
                      fontSize: theme.textTheme.titleMedium!.fontSize),
                ),
              ],
            )
          ],
        ),
        onTap: () {});
  }
}
