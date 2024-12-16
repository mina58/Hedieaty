import 'package:hedieaty/repositories/UserRepository.dart';

import '../models/Event.dart';
import '../models/User.dart';

class FirebaseEventRepository {

  final UserRepository _userRepository;

  FirebaseEventRepository(this._userRepository);
  Future<List<Event>> getEventsByPhone(String phone) async{
    await Future.delayed(Duration(milliseconds: 100));
    return [Event(1, "firebase event", DateTime.parse("2001-01-01"), true, User("1", "sdaf", "dfsa", "dfsa", 234))];
  }
}