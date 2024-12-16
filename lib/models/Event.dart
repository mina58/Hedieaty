import 'package:hedieaty/models/User.dart';

class Event {
  Event(this.id, this.name, this.date, this.isPublished, this.owner);

  final int id;
  final String name;
  final DateTime date;
  final bool isPublished;
  final User owner;

  // Convert an Event object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'isPublished': isPublished,
      'owner': owner.toMap(),
    };
  }

  // Create an Event object from a Map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      map['id'] as int,
      map['name'] as String,
      DateTime.parse(map['date'] as String),
      map['isPublished'] as bool,
      User.fromMap(map['owner']),
    );
  }

  Event copyWith({
    int? id,
    String? name,
    DateTime? date,
    bool? isPublished,
    User? owner,
  }) {
    return Event(
      id ?? this.id,
      name ?? this.name,
      date ?? this.date,
      isPublished ?? this.isPublished,
      owner ?? this.owner,
    );
  }
}
