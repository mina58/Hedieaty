import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventScreenArguments.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import 'package:provider/provider.dart';
import '../models/Event.dart';
import '../models/User.dart';
import '../services/EventsService.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({
    Key? key,
  }) : super(key: key);

  void _showCreateEventDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _eventNameController = TextEditingController();
    DateTime? _selectedDate;

    void _pickDate() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
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
          title: Text('Create Event'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                    ),
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
                    child: Text('Pick Date'),
                  ),
                  if (_selectedDate != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Selected Date: ${_selectedDate!.toLocal()}"
                            .split(' ')[0],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                    _selectedDate != null) {
                  final eventsService =
                      Provider.of<EventsService>(context, listen: false);
                  try {
                    Event event = await eventsService.addEvent(
                      _eventNameController.text.trim(),
                      _selectedDate!,
                    );
                    _eventNameController.clear();
                    User owner = await Provider.of<OwnerUserService>(context,
                            listen: false)
                        .getOwner();
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, "/event",
                        arguments:
                            EventScreenArguments(event, true, owner));
                  } catch (e) {
                    // Show error message if event creation fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else if (_selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a date')),
                  );
                }
              },
              child: Text('Create Event'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.tertiary,
        foregroundColor: theme.colorScheme.onTertiary,
        elevation: 5,
      ),
      onPressed: () {
        _showCreateEventDialog(context);
      },
      child: Icon(
        Icons.celebration,
        color: theme.colorScheme.onTertiary,
      ),
    );
  }
}
