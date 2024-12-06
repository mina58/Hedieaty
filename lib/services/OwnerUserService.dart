import 'package:hedieaty/models/User.dart';
import 'package:image_picker/image_picker.dart';

class OwnerUserService {
  Future<User> getOwner() async {
    await Future.delayed(const Duration(seconds: 2));
    return User(
      "John Doe",
      "1234567",
      "https://avatar.iran.liara.run/public",
      0,
    );
  }

  Future<void> updateUserName(String newName) async{
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateProfilePicture(XFile pickedFile) async{
    await Future.delayed(const Duration(seconds: 1));
  }
}