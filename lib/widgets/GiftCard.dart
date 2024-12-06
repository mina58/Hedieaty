import 'package:flutter/material.dart';
import 'package:hedieaty/models/Gift.dart';
import 'package:hedieaty/services/GiftsService.dart';
import 'package:hedieaty/widgets/EditButton.dart';
import 'package:hedieaty/widgets/MyCard.dart';
import 'package:provider/provider.dart';
import 'PledgeButton.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({
    super.key,
    required this.isOwnerGiftCard,
    required this.gift,
  });

  final bool isOwnerGiftCard;
  final Gift gift;

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  late bool _isPledged;

  @override
  void initState() {
    super.initState();
    _isPledged = widget.gift.isPledged;
  }

  void handlePledge() async {
    if (_isPledged) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('This gift is already pledged'),
        ),
      );
      return;
    }
    if (await Provider.of<GiftsService>(context, listen: false)
        .pledgeGift(widget.gift.id)) {
      setState(() {
        _isPledged = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('This gift is already pledged'),
        ),
      );
    }
  }

  void handleEdit() {
    if (_isPledged) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('This gift is already pledged'),
        ),
      );
    } else {
      // open dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(children: [
      MyCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.gift.name,
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  widget.gift.category,
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
            Column(
              children: [
                ...(!widget.isOwnerGiftCard
                    ? [
                        PledgeButton(
                          is_pledged: _isPledged,
                          onPressed: this.handlePledge,
                        )
                      ]
                    : [EditButton(onPressed: this.handleEdit)]),
                Text("\$${widget.gift.price.toString()}")
              ],
            )
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, "/gift_details");
        },
      ),
      ...(_isPledged
          ? [
              Transform.rotate(
                angle: -0.3,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ]
          : [])
    ]);
  }
}
