import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventScreenArguments.dart';
import 'package:hedieaty/services/GiftsService.dart';
import 'package:hedieaty/widgets/AsyncListView.dart';
import 'package:hedieaty/widgets/EditButton.dart';
import 'package:hedieaty/widgets/GiftCard.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:hedieaty/widgets/SortOptions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/Event.dart';
import '../models/Gift.dart';
import '../widgets/SortByOption.dart';

class EventScreen extends StatefulWidget {
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String _sortBy = "name";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EventScreenArguments arguments =
    ModalRoute.of(context)!.settings.arguments as EventScreenArguments;
    final GiftsService giftsService = Provider.of<GiftsService>(context);
    final bool isOwnerEvent = arguments.isOwnerEvent;
    final Event event = arguments.event;
    final String username = arguments.username;
    Future<List<Gift>> _gifts =
    giftsService.getEventGifts(event.id, _sortBy);

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            EventScreenHeader(
              theme: theme,
              isOwnerEvent: isOwnerEvent,
              username: username,
              event: event,
              onAddGiftPressed: () {
                setState(() {
                  _gifts = giftsService.getEventGifts(event.id, _sortBy);
                });
              },
            ),
            const SizedBox(height: 8),
            SortOptionsWidget(
              currentSortBy: _sortBy,
              onSortChange: (sortBy) {
                setState(() {
                  _sortBy = sortBy;
                  _gifts = giftsService.getEventGifts(event.id, _sortBy);
                });
              },
            ),
            Expanded(
              child: GiftsList(
                giftsFuture: _gifts,
                isOwnerEvent: isOwnerEvent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventScreenHeader extends StatelessWidget {
  const EventScreenHeader({
    super.key,
    required this.theme,
    required this.isOwnerEvent,
    required this.username,
    required this.event,
    required this.onAddGiftPressed,
  });

  final ThemeData theme;
  final bool isOwnerEvent;
  final String username;
  final Event event;
  final VoidCallback onAddGiftPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EventDetails(
          theme: theme,
          eventName: event.name,
          username: username,
          eventDate: event.date,
        ),
        if (isOwnerEvent)
          Row(
            children: [
              EditButton(onPressed: () {}),
              IconButton(
                icon: Icon(Icons.add),
                tooltip: "Add Gift",
                onPressed: () => _showAddGiftForm(context, event.id),
              ),
            ],
          ),
      ],
    );
  }

  void _showAddGiftForm(BuildContext context, int eventId) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _categoryController = TextEditingController();
    File? _selectedImage;

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Gift'),
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
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Upload Image'),
                  ),
                  if (_selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.file(
                        _selectedImage!,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
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
                if (_formKey.currentState?.validate() == true &&
                    _selectedImage != null) {
                  final giftsService =
                  Provider.of<GiftsService>(context, listen: false);
                  await giftsService.addGift(
                    eventId: eventId,
                    name: _nameController.text.trim(),
                    price: int.parse(_priceController.text.trim()),
                    description: _descriptionController.text.trim(),
                    category: _categoryController.text.trim(),
                    imageUrl: _selectedImage!.path, // Use file path as image URL
                  );
                  Navigator.of(context).pop();
                  onAddGiftPressed();
                } else if (_selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please upload an image')),
                  );
                }
              },
              child: Text('Add Gift'),
            ),
          ],
        );
      },
    );
  }
}

class EventDetails extends StatelessWidget {
  const EventDetails({
    super.key,
    required this.theme,
    required this.eventName,
    required this.username,
    required this.eventDate,
  });

  final ThemeData theme;
  final String eventName;
  final String username;
  final DateTime eventDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventName,
          style: theme.textTheme.headlineLarge,
        ),
        Text(
          username,
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          "${eventDate.day}/${eventDate.month}/${eventDate.year}",
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class SortOptionsWidget extends StatelessWidget {
  const SortOptionsWidget({
    super.key,
    required this.currentSortBy,
    required this.onSortChange,
  });

  final String currentSortBy;
  final ValueChanged<String> onSortChange;

  @override
  Widget build(BuildContext context) {
    return SortOptions(
      options: [
        SortByOption(
          text: "name",
          onTap: () => onSortChange("name"),
        ),
        SortByOption(
          text: "date",
          onTap: () => onSortChange("date"),
        ),
        SortByOption(
          text: "status",
          onTap: () => onSortChange("status"),
        ),
      ],
    );
  }
}

class GiftsList extends StatelessWidget {
  const GiftsList({
    super.key,
    required this.giftsFuture,
    required this.isOwnerEvent,
  });

  final Future<List<Gift>> giftsFuture;
  final bool isOwnerEvent;

  @override
  Widget build(BuildContext context) {
    return AsyncListView(
      future: giftsFuture,
      builder: (gift) => GiftCard(
        isOwnerGiftCard: isOwnerEvent,
        gift: gift,
      ),
    );
  }
}
