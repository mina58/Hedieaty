import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/MyCard.dart';
import 'PledgeButton.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({
    super.key,
    required this.isOwnerGiftCard,
    required this.theme,
    required this.isPledged,
  });

  final bool isOwnerGiftCard;
  final ThemeData theme;
  final bool isPledged;

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  late bool _is_pledged;


  @override
  void initState() {
    super.initState();
    _is_pledged = widget.isPledged;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MyCard(
        theme: widget.theme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PS5",
                  style: widget.theme.textTheme.titleLarge,
                ),
                Text(
                  "gaming",
                  style: widget.theme.textTheme.bodyLarge,
                )
              ],
            ),
            Column(
              children: [
                PledgeButton(
                  theme: widget.theme,
                  is_pledged: widget.isPledged,
                  onPressed: () {
                    setState(() {
                      _is_pledged = !_is_pledged;
                    });
                  },
                ),
                Text("\$100")
              ],
            )
          ],
        ),
        onTap: () {},
      ),
      ...(_is_pledged ? [Transform.rotate(
        angle: -0.3,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: widget.theme.colorScheme.secondaryContainer,
          child: Icon(
            Icons.person,
            color: widget.theme.colorScheme.onSecondaryContainer,
          ),
        ),
      ),] : [])
    ]);
  }
}
