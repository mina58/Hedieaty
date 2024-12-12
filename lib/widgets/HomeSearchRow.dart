import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/AddEventButton.dart';

class HomeSearchRow extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearchChanged;

  const HomeSearchRow({
    Key? key,
    required this.controller,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 175,
          height: 40,
          child: TextField(
            controller: controller,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              // Center text vertically
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                print("Tapped add friends");
              },
              child: Icon(Icons.add),
            ),
            AddEventButton(),
          ],
        )
      ],
    );
  }
}
