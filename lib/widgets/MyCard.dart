import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.child,
    required this.onTap,
  });


  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
