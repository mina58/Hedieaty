import '../models/Event.dart';

class FirebaseEventRepository {
  Future<List<Event>> getEventsByPhone(String phone) async{
    await Future.delayed(Duration(milliseconds: 100));
    return [Event(1, "firebase event", DateTime.parse("2001-01-01"), true)];
  }
}