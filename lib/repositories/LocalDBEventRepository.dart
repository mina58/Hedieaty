import '../models/Event.dart';
import '../models/User.dart';

class LocalDBEventRepository {
  Future<Event> addEventForUser(Event event) async {
    await Future.delayed(Duration(milliseconds: 100));
    return event;
  }

  Future<List<Event>> getEventsByPhone(String phone) async{
    await Future.delayed(Duration(milliseconds: 100));
    return [Event(1, "local event", DateTime.parse("2000-01-30"), false, User("1", "sdaf", "dfsa", "dfsa", 234))];
  }

  Future<Event?> getEventById(int id) async {
    await Future.delayed(Duration(milliseconds: 100));
    return Event(id, "name", DateTime.parse("2020-2-20"), false, User("1", "sdaf", "dfsa", "dfsa", 234));
  }

  Future<void> updateEvent(Event event) async {
    await Future.delayed(Duration(milliseconds: 100));
  }
}
