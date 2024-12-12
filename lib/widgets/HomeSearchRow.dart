import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/AddEventButton.dart';

import 'package:flutter/material.dart';
import 'package:hedieaty/widgets/AddEventButton.dart';
import 'package:provider/provider.dart';

import '../services/FriendsService.dart';

class HomeSearchRow extends StatefulWidget {
  const HomeSearchRow({
    Key? key,
    required this.controller,
    required this.onSearchChanged,
    required this.onAddFriend,
  }) : super(key: key);

  final TextEditingController controller;
  final ValueChanged<String> onSearchChanged;
  final void Function() onAddFriend;

  @override
  State<HomeSearchRow> createState() => _HomeSearchRowState();
}

class _HomeSearchRowState extends State<HomeSearchRow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _showAddFriendDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Friend'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Friend Name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Friend Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a phone number';
                      }
                      // You could add additional validation for phone format here
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  final friendsService =
                      Provider.of<FriendsService>(context, listen: false);
                  await friendsService.addFriend(
                    _nameController.text.trim(),
                    _phoneController.text.trim(),
                  );
                  // Clear controllers after adding
                  _nameController.clear();
                  _phoneController.clear();
                  Navigator.of(context).pop();
                  widget.onAddFriend();
                }
              },
              child: Text('Add Friend'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 175,
          height: 40,
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onSearchChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              // This ensures vertical centering of text
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: _showAddFriendDialog,
              child: Icon(Icons.add),
            ),
            AddEventButton(),
          ],
        )
      ],
    );
  }
}
