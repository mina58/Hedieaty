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
import '../models/User.dart';
import '../services/EventsService.dart';
import '../widgets/NotificationListener.dart';
import '../widgets/SortByOption.dart';

class EventScreen extends StatefulWidget {
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String _sortBy = "name";
  late Future<List<Gift>> _gifts;
  late bool isOwnerEvent;
  late Event event;
  late User user;
  late GiftsService giftsService;

  void _loadGifts() {
    setState(() {
      _gifts = giftsService.getEventGifts(event, _sortBy);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final EventScreenArguments arguments =
          ModalRoute.of(context)!.settings.arguments as EventScreenArguments;
      giftsService = Provider.of<GiftsService>(context, listen: false);
      setState(() {
        isOwnerEvent = arguments.isOwnerEvent;
        event = arguments.event;
        user = arguments.user;
        _gifts = giftsService.getEventGifts(event, _sortBy);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(displayProfile: true),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                EventScreenHeader(
                  theme: theme,
                  isOwnerEvent: isOwnerEvent,
                  username: user.name,
                  event: event,
                  onAddGiftPressed: _loadGifts,
                  onEditEvent: (newEvent) {
                    setState(() {
                      event = newEvent;
                    });
                  },
                ),
                const SizedBox(height: 8),
                SortOptionsWidget(
                  currentSortBy: _sortBy,
                  onSortChange: (sortBy) {
                    setState(() {
                      _sortBy = sortBy;
                      _loadGifts();
                    });
                  },
                ),
                Expanded(
                  child: GiftsList(
                    giftsFuture: _gifts,
                    isOwnerEvent: isOwnerEvent,
                    onPledge: _loadGifts,
                    onEdit: _loadGifts,
                  ),
                ),
              ],
            ),
          ),
          MyNotificationListener(),
        ],
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
    required this.onEditEvent,
  });

  final ThemeData theme;
  final bool isOwnerEvent;
  final String username;
  final Event event;
  final VoidCallback onAddGiftPressed;
  final void Function(Event) onEditEvent;

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
              if (!event.isPublished)
                EditButton(onPressed: () => _showEditEventForm(context, event)),
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

  void _showEditEventForm(BuildContext context, Event event) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: event.name);
    DateTime _selectedDate = event.date;

    Future<void> _pickDate() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        _selectedDate = pickedDate;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Event Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an event name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text("Select Date"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Selected Date: ${_selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  try {
                    final eventService =
                        Provider.of<EventsService>(context, listen: false);
                    final newEvent = await eventService.editEvent(
                      event.id,
                      _nameController.text.trim(),
                      _selectedDate,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Event updated successfully')),
                    );
                    Navigator.of(context).pop();
                    onEditEvent(newEvent);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to update event: $e.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _showAddGiftForm(BuildContext context, String eventId) {
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
                if (_formKey.currentState?.validate() == true) {
                  final giftsService =
                      Provider.of<GiftsService>(context, listen: false);
                  await giftsService.addGift(
                    event: event,
                    name: _nameController.text.trim(),
                    price: int.parse(_priceController.text.trim()),
                    description: _descriptionController.text.trim(),
                    category: _categoryController.text.trim(),
                    imageUrl:
                        _selectedImage?.path ?? "https://hedieaty.s3.us-east-1.amazonaws.com/download.jpg", // Use file path as image URL
                  );
                  Navigator.of(context).pop();
                  onAddGiftPressed();
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
          text: "category",
          onTap: () => onSortChange("category"),
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
    required this.onPledge,
    required this.onEdit,
  });

  final Future<List<Gift>> giftsFuture;
  final bool isOwnerEvent;
  final void Function() onPledge;
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return AsyncListView(
      future: giftsFuture,
      builder: (gift) => GiftCard(
        isOwnerGiftCard: isOwnerEvent,
        gift: gift,
        onPledge: onPledge,
        onEdit: onEdit,
      ),
    );
  }
}
