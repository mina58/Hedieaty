import 'package:flutter/material.dart';
import 'package:hedieaty/services/GiftsService.dart';
import 'package:hedieaty/widgets/AsyncListView.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/MyCard.dart';
import 'package:provider/provider.dart';

import '../models/Gift.dart';
import '../widgets/PledgedGiftCard.dart';

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
              return PledgedGiftCard(gift: pledgedGift);
            }),
      ),
    );
  }
}
