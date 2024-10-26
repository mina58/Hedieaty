import 'package:flutter/material.dart';

class PledgeButton extends StatefulWidget {
  const PledgeButton({
    super.key,
    required this.is_pledged,
    required this.theme,
    required this.onPressed,
  });

  final bool is_pledged;
  final ThemeData theme;
  final Function onPressed;

  @override
  State<PledgeButton> createState() => _PledgeButtonState();
}

class _PledgeButtonState extends State<PledgeButton> {
  late bool _isPledge;

  @override
  void initState() {
    super.initState();
    _isPledge = widget.is_pledged;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isPledge = !_isPledge;
        });
        widget.onPressed();
      },
      icon: Icon(Icons.card_giftcard),
      style: IconButton.styleFrom(
          backgroundColor: _isPledge
              ? widget.theme.colorScheme.tertiary
              : widget.theme.colorScheme.primary,
          foregroundColor: _isPledge
              ? widget.theme.colorScheme.onTertiary
              : widget.theme.colorScheme.onPrimary),
    );
  }
}
