import 'package:flutter/material.dart';
import 'package:hedieaty/routingArguments/EventListScreenArguments.dart';
import 'package:hedieaty/services/OwnerUserService.dart';
import 'package:hedieaty/widgets/MyAppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../widgets/EditButton.dart';

class OwnerProfileScreen extends StatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  State<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends State<OwnerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final OwnerUserService ownerUserService =
        Provider.of<OwnerUserService>(context);
    final Future<User> user = ownerUserService.getOwner();

    return Scaffold(
      appBar: MyAppBar(displayProfile: false),
      body: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return OwnerProfileContent(
              user: snapshot.data!,
              ownerUserService: ownerUserService,
              onUpdate: () {
                setState(() {});
              }, // Pass the service here
            );
          } else {
            return Text("Failed to get user");
          }
        },
      ),
    );
  }
}

class OwnerProfileContent extends StatelessWidget {
  const OwnerProfileContent({
    super.key,
    required this.user,
    required this.ownerUserService,
    required this.onUpdate,
  });

  final User user;
  final OwnerUserService ownerUserService;
  final void Function() onUpdate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 100,
                  child: Image.network(user.imageUrl),
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      _showImagePickerDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(width: 10),
                    EditButton(
                      onPressed: () {
                        _showEditNameDialog(context);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/event_list",
                          arguments: EventListScreenArguments(
                            true,
                            user,
                          ),
                        );
                      },
                      child: Text("Events"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.tertiary,
                        foregroundColor: theme.colorScheme.onTertiary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/pledged_gifts");
                      },
                      child: Text("Pledged Gifts"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        foregroundColor: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Function to show the dialog to update the name
  void _showEditNameDialog(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: user.name);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Enter new name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newName = nameController.text.trim();
                if (newName.isNotEmpty && newName != user.name) {
                  try {
                    await ownerUserService.updateUserName(newName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Name updated successfully!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update name')),
                    );
                  }
                  Navigator.of(dialogContext).pop();
                  onUpdate(); // Close dialog
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the dialog for image picker
  void _showImagePickerDialog(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
            await ownerUserService.updateProfilePicture(pickedFile);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile picture updated successfully!')),
        );
        onUpdate(); // Update the UI
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile picture')),
        );
      }
    }
  }
}
