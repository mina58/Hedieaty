import 'package:flutter/material.dart';
import 'package:hedieaty/models/Gift.dart';
import 'package:hedieaty/routingArguments/GiftDetailsScreenArguments.dart';
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

  void _handleEdit() {
    if (_isPledged) {
      _showSnackBar('This gift is already pledged');
      return;
    }
    _showEditGiftDialog();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showEditGiftDialog() {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: widget.gift.name);
    final _priceController = TextEditingController(text: widget.gift.price.toString());
    final _descriptionController = TextEditingController(text: widget.gift.description);
    final _categoryController = TextEditingController(text: widget.gift.category);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Gift'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Gift Name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a gift name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a category';
                      }
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
                  final giftsService = Provider.of<GiftsService>(context, listen: false);
                  await giftsService.updateGift(
                    giftId: widget.gift.id,
                    name: _nameController.text.trim(),
                    price: int.parse(_priceController.text.trim()),
                    description: _descriptionController.text.trim(),
                    category: _categoryController.text.trim(),
                  );
                  Navigator.of(context).pop();
                  _showSnackBar('Gift updated successfully');
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
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
                  ),
                ],
              ),
              Column(
                children: [
                  if (widget.isOwnerGiftCard)
                    EditButton(onPressed: _handleEdit),
                  Text("\$${widget.gift.price}"),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              "/gift_details",
              arguments: GiftDetailsScreenArguments(widget.gift),
            );
          },
        ),
        if (_isPledged)
          Transform.rotate(
            angle: -0.3,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: theme.colorScheme.secondaryContainer,
              child: CircleAvatar(
                child: Image.network(widget.gift.pledgedBy!.imageUrl),
              ),
            ),
          ),
      ],
    );
  }
}
